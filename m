Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7B4FC1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiDKQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348372AbiDKQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:01:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59DC63AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:59:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b16so19248694ioz.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCc0FZlMvykgvFYw2XHdGQELMz2VKN98c/Q9KH+ZtDs=;
        b=iy8tb+hIM2PgZGTGKuxPugckzBXFUgOzW/h31MUOxXssoGT6TNWpEghCY5t4srbHsl
         Q+wizxaCgOUc+qhsL701jf5Nd238RKa065TLu6Z7Vc/e/AbfHaLXdr23qtZ0weP5hAjP
         KAjmxvu38jPSX7YrhC5ClGa4FFI3j4C1J0z/FnooxQGa6481gTP3zA1TTul7ST/v3j+V
         KmpHD9+3tq23qlqHVtc4d1wA+vXrSm2zx7r+5aEmYw9PhO3ESHbKsktvfsC4QgPXZV73
         BQ1XFDf+zT3midbujNUDe1IIoxWFzDCJjR3wZwQuMdUsBGbjKcNNYkO9Bjos8B2PZcNu
         /iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCc0FZlMvykgvFYw2XHdGQELMz2VKN98c/Q9KH+ZtDs=;
        b=kUp+HO6uVm6x+n+5HgmzHPgaYzFoMpj/HuQT0d9f5sF1+/0/jvh4Cs+nUc7P7khmWa
         zU8kNcQJmvWF2kuLXjJ1z6ZyaJEmw+dJ6Yk6GJqhIbHl+lzd+sXmd+5lXMjFv1fyItnD
         1ru5DSpFyIsVD56MH9MTmj2eWD2VSmfySCR+6ut6SjPvaST8AiZ+LF6dKAUXXtPWY6B9
         Sqk4iyNtcKUX/xI8LkuThM4KWWGtxK1bzG6+jtDg6c/1ycD5Q1DI0Fm30vXNsttzsV4r
         TjcvRLL20uI77S9zQouuxZKSg7SR3QxNbKrSIovRvrz4l8CCEiv2ar2BRme4ImYCKfSH
         yQZg==
X-Gm-Message-State: AOAM530ewJM7god5fwTYo/uz91VoHxtIQm8WvVGtrqehIh3iP8dErMlU
        +zoZSioUOVW6/zW6eHHTatXMbw==
X-Google-Smtp-Source: ABdhPJxePCSq96Ornthg0O+PH5eNh2FWWJokPxKZEDqhEKjmBOIyql3V/8U1kSfhzCNgpEBUPxqocw==
X-Received: by 2002:a05:6638:25c2:b0:326:223d:4494 with SMTP id u2-20020a05663825c200b00326223d4494mr4292480jat.162.1649692749075;
        Mon, 11 Apr 2022 08:59:09 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i12-20020a926d0c000000b002c9db5fdf66sm19228701ilc.15.2022.04.11.08.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:59:08 -0700 (PDT)
Message-ID: <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org>
Date:   Mon, 11 Apr 2022 10:59:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, djakov@kernel.org,
        okukatla@codeaurora.org, quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>, mka@chromium.org,
        dianders@chromium.org
References: <20211125174751.25317-1-djakov@kernel.org>
 <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 6:00 PM, Stephen Boyd wrote:
> Quoting Georgi Djakov (2021-11-25 09:47:51)
>> From: Mike Tipton <mdtipton@codeaurora.org>
>>
>> We're only adding BCMs to the commit list in aggregate(), but there are
>> cases where pre_aggregate() is called without subsequently calling
>> aggregate(). In particular, in icc_sync_state() when a node with initial
>> BW has zero requests. Since BCMs aren't added to the commit list in
>> these cases, we don't actually send the zero BW request to HW. So the
>> resources remain on unnecessarily.
>>
>> Add BCMs to the commit list in pre_aggregate() instead, which is always
>> called even when there are no requests.
>>
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> [georgi: remove icc_sync_state for platforms with incomplete support]
>> Signed-off-by: Georgi Djakov <djakov@kernel.org>

I'm back from vacation and am finally giving proper attention to
this.  I want to make sure I understand the problem, because there
are (at least) two parts to it.

- The first problem you observe is that you are not seeing XO
   shutdown on suspend on a Lazor device.
- You didn't say this directly but I think you are seeing this
   on Linux v5.15.y (the 5.15 LTS branch), or perhaps on something
   derived from that branch.
- You find that if you back-port (or cherry-pick?) the commit
   that landed upstream as b95b668eaaa2 ("interconnect: qcom:
   icc-rpmh: Add BCMs to commit list in pre_aggregate
"), you
   *do* see XO shutdown on suspend, as desired.

Here's what I understand that commit to do:
- In some cases, the bus clock managers (BCMs) are configured
   by the boot loader so that some interconnects have non-zero
   initial bandwidth.
- There is no sense in keeping an interconnect active if Linux
   has nothing that requires its use.  So we would like Linux to
   ensure the configured bandwidth for an *unused* interconnect
   is zero.
- Prior to that commit, BCM-managed hardware was only queued
   to update its configuration when the ->aggregate interconnect
   provider function was called.  After that commit, updates were
   queued by the ->pre_aggregate provider function.
- Unlike the ->aggregate callback, the ->pre_aggregate provider
   function queues updates to the hardware configuration whether
   or not they have active users.
- The result of this commit is that the hardware configuration
   for all defined BCM-managed interconnects is updated, and in
   particular, the configured bandwidth for unused interconnects
   is set to zero.

When unused interconnects are configured for zero bandwidth, they
do not require an active main XO clock, and so with this commit
it becomes possible for the XO clock to be shut down.

And that's why this commit addresses your XO shutdown problem on
the Linux 5.15 LTS branch.

Is the above an accurate description?

Looking at that branch, I see this commit:  f753067494c27
("Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit
list in pre_aggregate"
").  Which shows that an attempt was made
to include this commit in the 5.15 LTS branch, but it caused
some *other* regressions.  That suggests this might not be
easy to fix.

---

The second problem you have is exhibited by the IPA driver if
the "fix" commit (upstream b95b668eaaa2) is back-ported to the
Linux 5.10.y LTS branch (along with some other prerequisite
commits).  We can conclude that applying the above commit
makes the bandwidth for an unused interconnect (or perhaps
the rate for the IPA core clock) get set to zero.  And in that
case, an attempt to access IPA hardware leads to the crash you
observed.

The IPA driver does not implement runtime power management
until Linux v5.15.  You later said you thought enabling that
might ensure the clock and interconnects were active when
needed by the IPA driver, and I concur (but there could be a
little more to it).

In any case, based on the time stamp in your log, it seems
this problem is likely occurring upon the first access to IPA
hardware.

I have a hunch about what might be happening here.  There is
some synchronization that must occur between the AP and modem
when IPA is starting up.  Until that synchronization step has
completed, we can't allow the IPA network device to be opened.
In later kernels I think this is precluded, but perhaps in
Linux v5.10 it isn't.  Until I look a little more closely I'm
not sure what would happen, but it *could* be this.

I'm going to look a little how the particular access that
caused the crash is prevented in newer kernels.  It could
be that back-porting that (or re-implementing it for the
older kernel) will address the crash you're seeing.

					-Alex

> This patch fixes suspend/resume for me on sc7180-trogdor-lazor. Without
> it I can't achieve XO shutdown. It seems that it fixes the sync_state
> support that was added in commit b1d681d8d324 ("interconnect: Add sync
> state support"). Before that commit suspend worked because the
> interconnect wasn't maxed out at boot. After that commit we started
> maxing out the interconnect state and never dropping it.
> 
> It would be good to pick this back to stable kernels so we have a
> working suspend/resume on LTS kernels. I tried picking it back to
> 5.10.109 (latest 5.10 LTS) and booting it on my Lazor w/ LTE device but
> it crashes at boot pretty reliably in the IPA driver. Interestingly I
> can't get it to crash on 5.15.32 when I pick it back, so maybe something
> has changed between 5.10 and 5.15 for IPA? I'll try to bisect it.
> 
> [   23.708432] Internal error: synchronous external abort: 96000010
> [#1] PREEMPT SMP
> [   23.708451] Modules linked in: veth rfcomm algif_hash
> algif_skcipher af_alg uinput xt_MASQUERADE uvcvideo videobuf2_vmalloc
> venus_enc venus_dec videobuf2_dma_sg videobuf2_memops venus_core
> v4l2_mem2mem videobuf2_v4l2 cros_ec_typec videobuf2_common hci_uart
> typec btqca qcom_q6v5_mss ipa qcom_pil_info qcom_q6v5 qcom_common
> rmtfs_mem ip6table_nat fuse 8021q bluetooth ecdh_generic ecc
> ath10k_snoc ath10k_core ath lzo_rle lzo_compress mac80211 zram
> cfg80211 r8152 mii joydev
> [   23.708565] CPU: 5 PID: 3706 Comm: mmdata_mgr Not tainted 5.10.109+ #61
> [   23.708571] Hardware name: Google Lazor (rev1+) with LTE (DT)
> [   23.708578] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [   23.708597] pc : gsi_channel_start+0x78/0x1dc [ipa]
> [   23.708609] lr : gsi_channel_start+0x4c/0x1dc [ipa]
> [   23.708614] sp : ffffffc013d9ba20
> [   23.708619] x29: ffffffc013d9ba20 x28: 0000000000000000
> [   23.708628] x27: 0000000000000000 x26: ffffffc013d9bc20
> [   23.708637] x25: 000000000001c000 x24: 0000000000000000
> [   23.708646] x23: ffffffab00cb9410 x22: 00000000712dcf80
> [   23.708654] x21: ffffffab486bc148 x20: ffffffab486b8a18
> [   23.708663] x19: ffffffab486b8000 x18: 00000000ffff0a00
> [   23.708671] x17: 000000002f7254f1 x16: ffffffeb3db6f344
> [   23.708680] x15: 00000000ffee6094 x14: ffffffffffffffff
> [   23.708689] x13: 0000000000000010 x12: 0101010101010101
> [   23.708697] x11: 000000000000013c x10: 0000000000000000
> [   23.708706] x9 : 000000000001c000 x8 : ffffffc018f1c000
> [   23.708715] x7 : fefefefefeff2f60 x6 : 0000808080808080
> [   23.708724] x5 : 0000000000000000 x4 : 8080808080800000
> [   23.708732] x3 : 0000000000000000 x2 : ffffffab5089eac0
> [   23.708741] x1 : 0000000000000000 x0 : 0000000000000000
> [   23.708750] Call trace:
> [   23.708762]  gsi_channel_start+0x78/0x1dc [ipa]
> [   23.708773]  ipa_endpoint_enable_one+0x34/0xc0 [ipa]
> [   23.708785]  ipa_open+0x30/0x98 [ipa]
> [   23.708795]  __dev_open+0xd8/0x190
> [   23.708803]  __dev_change_flags+0xbc/0x1c8
> [   23.708810]  dev_change_flags+0x30/0x70
> [   23.708818]  devinet_ioctl+0x274/0x500
> [   23.708824]  inet_ioctl+0x10c/0x394
> [   23.708831]  sock_do_ioctl+0x58/0x324
> [   23.708837]  compat_sock_ioctl+0x238/0xdb0
> [   23.708845]  __arm64_compat_sys_ioctl+0xcc/0x104
> [   23.708854]  el0_svc_common+0xec/0x1dc
> [   23.708860]  do_el0_svc_compat+0x28/0x54
> [   23.708868]  el0_svc_compat+0x10/0x1c
> [   23.708874]  el0_sync_compat_handler+0xc0/0xf0
> [   23.708880]  el0_sync_compat+0x184/0x1c0
> [   23.708890] Code: 51286129 53037d29 1b166529 8b090108 (b9400108)
> 
> Note I had to pick a handful of other patches for nvmem to get normal
> boot on 5.10.109. I'll send those over to stable maintainers shortly.
> 
> 	fd3bb8f54a88 ("nvmem: core: Add support for keepout regions")
> 	de0534df9347 ("nvmem: core: fix error handling while validating
> keepout regions")
> 	044ee8f85267 ("nvmem: qfprom: Don't touch certain fuses")
> 	437145dbcdee ("arm64: dts: qcom: sc7180: Add soc-specific qfprom
> compat string")
> 	437cdef515e2 ("arm64: dts: qcom: sc7180:: modified qfprom CORR size
> as per RAW size")

