Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25546C663
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhLGVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:13:05 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:35990 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhLGVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:38 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:51446)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1muhhv-001ifU-3F; Tue, 07 Dec 2021 14:09:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60992 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1muhht-008wfq-0g; Tue, 07 Dec 2021 14:09:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
        <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
        <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
Date:   Tue, 07 Dec 2021 15:08:03 -0600
In-Reply-To: <Ya/BnndSXKHiUpGm@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 7 Dec 2021 12:18:38 -0800")
Message-ID: <875ys0azt8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1muhht-008wfq-0g;;;mid=<875ys0azt8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gCLiE4BbllrCAkTyVw19+r+viE4ZO5KA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4781]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1512 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (0.3%), b_tie_ro: 3.1 (0.2%), parse: 1.16
        (0.1%), extract_message_metadata: 11 (0.7%), get_uri_detail_list: 2.4
        (0.2%), tests_pri_-1000: 6 (0.4%), tests_pri_-950: 1.05 (0.1%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 101 (6.7%), check_bayes:
        100 (6.6%), b_tokenize: 7 (0.5%), b_tok_get_all: 9 (0.6%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 78 (5.1%), b_finish: 0.76
        (0.1%), tests_pri_0: 1372 (90.8%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.16 (0.0%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the sysctl table of each feature
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, Dec 06, 2021 at 05:38:42PM -0800, Andrew Morton wrote:
>> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
>> > --- a/fs/inode.c
>> > +++ b/fs/inode.c
>> > @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
>> >  	{ }
>> >  };
>> >  
>> > -static int __init init_fs_inode_sysctls(void)
>> > -{
>> > -	register_sysctl_init("fs", inodes_sysctls);
>> > -	return 0;
>> > -}
>> > -early_initcall(init_fs_inode_sysctls);
>> > +fs_sysctl_initcall(inodes_sysctls);
>> >  #endif
>> 
>> Here's another, of many.
>> 
>> Someone made the decision to use early_initcall() here (why?) and this
>> patch switches it to late_initcall()!  Worrisome.  Each such stealth
>> conversion should be explained and justified, shouldn't it?
>
> I made the decisions for quite a bit of the ordering and yes I agree
> this need *very careful* explanation, specially if we are going to
> generalize this.
>
> First and foremost. git grep for sysctl_init_bases and you will see
> that the bases for now are initialized on proc_sys_init() and that
> gets called on proc_root_init() and that in turn on init/main.c's
> start_kernel(). And so this happens *before* the init levels.
>
> The proper care for what goes on top of this needs to take into
> consideration the different init levels and that the if a sysctl
> is using a directory *on top* of a base, then that sysctl registration
> must be registered *after* that directory. The *base* directory for
> "fs" is now registered through fs/sysctls.c() on init_fs_sysctls()
> using register_sysctl_base(). I made these changes with these names
> and requiring the DECLARE_SYSCTL_BASE() so it would be easy for us
> to look at where these are declared.
>
> So the next step in order to consider is *link* ordering and that
> order is maintained by the Makefile. That is why I put this at the
> top of the fs Makfile:
>
> obj-$(CONFIG_SYSCTL)            += sysctls.o 
>
> So any file after this can use early_initcall(), because the base
> for "fs" was declared first in link order, and it used early_initcall().
> It is fine to have the other stuff that goes on top of the "fs" base
> use late_initcall() but that assumes that vetting has been done so that
> if a directory on "fs" was created, let's call it "foo", vetting was done
> to ensure that things on top of "foo" are registered *after* the "foo"
> directory.
>
> We now have done the cleanup for "fs", and we can do what we see fine
> for "fs", but we may run into surprises later with the other bases, so
> I'd be wary of making assumptions at this point if we can use
> late_initcall().
>
> So, as a rule of thumb I'd like to see bases use early_initcall(). The
> rest requires manual work and vetting.
>
> So, how about this, we define fs_sysctl_initcall() to use also
> early_initcall(), and ask susbsystems to do their vetting so that
> the base also gets linked first.
>
> After this, if a directory on top of a base is created we should likely create
> a new init level and just bump that to use the next init level. So
> something like fs_sysctl_base_initcall_subdir_1() map to core_initcall()
> and so on.
>
> That would allow us to easily grep for directory structures easily and
> puts some implicit onus of ordering on those folks doing these conversions.
> We'd document well the link order stuff for those using the base stuff
> too as that is likely only where this will matter most.

I am a bit confused at this explanation of things.

Last I looked the implementation of sysctls allocated the directories
independently of the sysctls entries that populated them.

Which should be that as long as there are not conflicts in name of
directory entries, any order should work.

Am I misremembering how the code works?


Eric
