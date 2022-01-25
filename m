Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE65949A7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315762AbiAYCyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:09 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:39108 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3408073AbiAYAVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:21:33 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:40422)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nC9aR-001AUJ-QT; Mon, 24 Jan 2022 17:21:28 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:53348 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nC9aP-00E0KF-8z; Mon, 24 Jan 2022 17:21:26 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220124213129.29306-1-rdunlap@infradead.org>
Date:   Mon, 24 Jan 2022 18:20:54 -0600
In-Reply-To: <20220124213129.29306-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Mon, 24 Jan 2022 13:31:29 -0800")
Message-ID: <87ee4w1x95.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nC9aP-00E0KF-8z;;;mid=<87ee4w1x95.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+l7gNz9P0ebhyrkVdO1CIxfUNRBVsTFsw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Randy Dunlap <rdunlap@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1443 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.6%), parse: 1.68 (0.1%),
         extract_message_metadata: 28 (2.0%), get_uri_detail_list: 2.4 (0.2%),
        tests_pri_-1000: 47 (3.3%), tests_pri_-950: 1.59 (0.1%),
        tests_pri_-900: 1.34 (0.1%), tests_pri_-90: 93 (6.5%), check_bayes: 91
        (6.3%), b_tokenize: 8 (0.6%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        2.7 (0.2%), b_tok_touch_all: 68 (4.7%), b_finish: 1.16 (0.1%),
        tests_pri_0: 1240 (85.9%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 3.6 (0.2%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next v2] ia64: make IA64_MCA_RECOVERY bool instead of
 tristate
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> In linux-next, IA64_MCA_RECOVERY uses the (new) function make_task_dead(),
> which is not exported for use by modules. Instead of exporting it for
> one user, convert IA64_MCA_RECOVERY to be a bool Kconfig symbol.
>
> In a config file from "kernel test robot <lkp@intel.com>" for a
> different problem, this linker error was exposed when
> CONFIG_IA64_MCA_RECOVERY=m.
>
> Fixes this build error:
>
> ERROR: modpost: "make_task_dead" [arch/ia64/kernel/mca_recovery.ko] undefined!

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

I looked and ia64_unreg_MCA_extension has no synchronization so I don't
think it has ever been safe to this code when built as a module.


> Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-ia64@vger.kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: kernel test robot <lkp@intel.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> ---
> v1 was [PATCH -next] exit: export make_task_dead().
> Christoph suggests and prefers that IA64 MCA recovery code just be
> forced to be builtin if it is enabled.
>
>  arch/ia64/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220121.orig/arch/ia64/Kconfig
> +++ linux-next-20220121/arch/ia64/Kconfig
> @@ -318,7 +318,7 @@ config ARCH_PROC_KCORE_TEXT
>  	depends on PROC_KCORE
>  
>  config IA64_MCA_RECOVERY
> -	tristate "MCA recovery from errors other than TLB."
> +	bool "MCA recovery from errors other than TLB."
>  
>  config IA64_PALINFO
>  	tristate "/proc/pal support"
