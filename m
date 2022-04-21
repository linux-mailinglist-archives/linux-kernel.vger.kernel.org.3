Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941850A375
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389862AbiDUO7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiDUO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:59:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5F43392;
        Thu, 21 Apr 2022 07:56:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650552979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kCmmeBFyKdPCM39jp9rfdUy/VRt431xwBuf3wpfKds=;
        b=2YIcM1pfi0m8RrAtM3GW/cEzGwM03IHx14kKmkky9jseLGxHS6boPU+SJS3IvaUX6qGz24
        PfmoWSDYkoxmvNYCv3P84Of2ewTlBA+PN2z5tNozCdUir+Z/MBJR/XaVDP7ljPv0HgZeGL
        Cnmfhky8wIhx7Rd+6IEwEpAMRdDJvOHMCk+yXqsqwuvg+PyHeu1CiF0YDOa8uDrbPCq4J5
        UGiu3wnbzj5PQgdtGSoI/sxK8GGpygszVEf5E4S6s0byZZpScssgN2Qez7XAPVcEwopsS+
        Wa8XMDCV4/5GDRwxI8InboSUHZvv9GCKdCy534HIpOyPzIvwJhIcsZCTu/WZIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650552979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kCmmeBFyKdPCM39jp9rfdUy/VRt431xwBuf3wpfKds=;
        b=cUFWYXFbRStTQNvqnNyN8QiNjcTaVlh1mE6iJSETtZjT1l9CRDvaI9pfkvMK+ZplQogoOE
        iEAdRr16VWtQrTDQ==
To:     Borislav Petkov <bp@alien8.de>,
        Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 01/10] x86/microcode/intel: expose
 collect_cpu_info_early() for IFS
In-Reply-To: <Yk/zhV3SGib6TaI5@zn.tnic>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220407191347.9681-2-jithu.joseph@intel.com> <Yk/zhV3SGib6TaI5@zn.tnic>
Date:   Thu, 21 Apr 2022 16:56:19 +0200
Message-ID: <871qxqtrho.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 10:34, Borislav Petkov wrote:
> On Thu, Apr 07, 2022 at 12:13:38PM -0700, Jithu Joseph wrote:
>> +EXPORT_SYMBOL_GPL(cpu_signatures_match);
>> +
>> +int cpu_collect_info_early(struct ucode_cpu_info *uci)
>
> intel_collect_cpu_info_early()

That function name does not make sense in context of that driver...

Thanks,

        tglx
