Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A84FBF71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbiDKOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbiDKOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:46:35 -0400
X-Greylist: delayed 2611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 07:44:18 PDT
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456662CA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649688253;
        bh=7GopoeoK8zI4GB2l2eUN6bBtjkL/7R2gwbjUIUdvthE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eW0xstcWUyT4B9NM20y9wT/R8QwUbOSYT12qUzbcidpHB88jhMuili6sd3tHDYBLu
         aEiTf0MP0DGz/NcR+RcAmeWEO+ykBdqCiDmT1KRD5ivDQIQh3/fa+cn8e1Ld31L1g4
         BYWS1a37n6HQTtjc7ufU4bm+8droRJbAhUYkzFdE=
Received: from [192.168.0.110] ([36.57.147.99])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id B092E6BD; Mon, 11 Apr 2022 22:44:09 +0800
X-QQ-mid: xmsmtpt1649688249tqqsw39z6
Message-ID: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
X-QQ-XMAILINFO: OUk+E8Vw5ntv/lqYBkZyCcCdpp8XhX2hlX1rqAcTh0BWTUq6rW9TdRRTC2ByXP
         k679H/OPozXD3bmep3k6pICozuz/THcQtK34zGXbsUR38rBK4pRZGKxWnRhm+1PfBFq7m3dI94nT
         Z+f0B1bqt0AbD5flZ6QUvO1kkofS2BpEUAONtJuQk0+4/u8l0Opugk4GV9C+noYnBjQ29QPstodw
         h/h7sJXnXkGRNdzxSYPhqRLMLjXIC2pLPzyUlktJ8uTG/CvrE8iBT0P+hRA13V8DY4MpkPeTR5eH
         bTZxqIowTrMOr4FwlffUmU4W6YXyuUO81oPOyPbN6nN5aOF/9CdbJTI9jlhav+v6SLNiW+FWFPWI
         OreZh4wqTZNqnjweUQjeb6iz5oIlMnl7RCfc8Jmr9sbmxqG+Y1bLis5B1ou1G8fbBPPlPTW+bBST
         YxFSd2/hhDFFBXSjpVzXC6N7A8EtJRkw03N0N2W8qwv/wMX2erwFxZV8FNnDy2b9SOoGYEj8jIy6
         3JEOFi05EhlLq3K+4Cef1dDBAmjGbi1pKtr9wLLquWLV2k4kwFG1Rs3FcUT3h6uARFVBse0nrj1/
         xnqeKqvrSSQJ3peIKIeN4YxuuOwVqTlusOhrYZn2MIh9uR5736hOzKTNEBPadYgg36UmFzYzSseO
         6XXTP2B0x2ImRwuHUs/D+k7nLv8Ly7BwHq0ofcpUMI8QtOXj3waYW6sxRFsHJOcZURfWQ9obyUlf
         Nox07YsIhL+6Ht5wmBNZrql5BOGE4VhlTgQ+K0d6fRox5Fn+/A0MJL/KWyMeCF0OwVfmKzILK3jG
         V+yE6tb6R68LUE+WIAkIUB/bhBc3tMwGOMxQOf4ib0CbsWzCobC6zicrHv4CqDcUCWcuJ6IlLok1
         2tOLf7HDm97/kydq4Q7ycxg22hdWYiyGZYDZ02FBO0CQQQYPexHbXRmLCcsn4Cbrlvck0as4wEfP
         3Fn80RAl9z/5qXlVuObrnCJ41VLPZ3nGHMNenmmMWJAZPRMzpsn0JSq652GkAGa7erphNFAQQ=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        jean-philippe <jean-philippe@linaro.org>
Cc:     Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <88055f44-3106-feca-aeac-d7272f3ee824@foxmail.com>
Date:   Mon, 11 Apr 2022 22:44:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/11 下午10:36, Dave Hansen wrote:
> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>> Is there nothing before this call trace?  Usually there will be at least
>>> some warning text.
>> I added dump_stack() in ioasid_free.
> Hold on a sec, though...
>
> What's the *problem* here?  Did something break or are you just saying
> that something looks weird to _you_?

After this, nginx is not working at all, and hardware reports error.
Suppose the the master use the ioasid for init, but got freed.

hardware reports:
[  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error 
status=0x20] found
[  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout 
[error status=0x40] found
[  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error 
status=0x20] found
[  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
[  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
[  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for 
stopping!
[  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for 
stopping!
[  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for 
stopping!
[  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!

Thanks

>
> For instance, if we have:
>
> 	nginx: ioasid_alloc()==1
> 	       fork(); // spawn the daemon
> 	       exit();
> 	       ioasid_free(1);
>
> and then a moment later:
>
> 	lynx:  ioasid_alloc()==1
> 	       fork();
> 	       exit();
> 	       ioasid_free(1);
>
> There's no problem.  The original nginx process with ioasid==1 exited.
> The fact that *some* process called nginx is still running doesn't mean
> that it still has a reference to asid==1.
>
> Are you sure the nginx process that allocated the ASID is the same
> process you see in ps?

