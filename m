Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9274F5294
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850690AbiDFCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839233AbiDFA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:58:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461F2261D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:00:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b188so621256oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lPDgMVKhVxKeCXKrPuEoIVFMhmA2yEb3C3oi2Xes+6k=;
        b=gHOL7LTMrxnklCuNfTN8OLLGqDu3UHOmyfR8eSl7liFI5QwM6xuJDXgKnMEYgN899N
         hge3Lo7qB6fm/yNvjZ+Ddz2Og1SFDXV0VhH1/iRMiXlYSuxXq6PZL6vXf8wStgzv5R/v
         XDy0WeQdtq40UDFwoC7DclZvuqGl2+zVdHBWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lPDgMVKhVxKeCXKrPuEoIVFMhmA2yEb3C3oi2Xes+6k=;
        b=kJD2eKJujgui4jBoentf2YFeVJAKWhhSrnZNr3nR/6b6yVfKGoS6sGlRlIpCq5ClPf
         H9AkevcdCAdjlvIjmpIIcTnBQ7iMu2adrMSDmigTNOMy2JRgL4ardcBk6Q+Jcf8i1wXP
         z5WvRw0s7mPrnS8V3GzO/T0xEFpt70wgNiM5E/qXw2i3vATpyWg1ZefIY5pUeUFnWmVw
         qF7LVnNk1NHnLfd+fsNUb5yESj6wD0IC2Ngc2M7zhI1TkbCKoztYwiKJ1kXpDEfzy358
         aZC0nPHelWrBFfOhEqv2beklUFfwLbbHt+nVdgV1TyZSPzdbQkb+3Fc00akOdyCGGl3n
         2eFA==
X-Gm-Message-State: AOAM533XrZCi1rO/jXszpdaZuQ6ldHJvk7vNtTSlTdzf93P9m4hCZJte
        7azHpNOKH4OKw6QNCtP1DV7WW1nIWSaWUdowlpgYEA==
X-Google-Smtp-Source: ABdhPJxCSVMEnrXY+hF/OuCW5io34UGmyAUO3utiTnVPb3Iq7pmV0sog7eZm6iuphLEAukerIB7Ksdux2Nbb1gkyyWY=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2404831oif.63.1649199656352; Tue, 05
 Apr 2022 16:00:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 16:00:55 -0700
MIME-Version: 1.0
In-Reply-To: <20211125174751.25317-1-djakov@kernel.org>
References: <20211125174751.25317-1-djakov@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 16:00:55 -0700
Message-ID: <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
To:     djakov@kernel.org, okukatla@codeaurora.org,
        quic_mdtipton@quicinc.com, Alex Elder <elder@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>, mka@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Georgi Djakov (2021-11-25 09:47:51)
> From: Mike Tipton <mdtipton@codeaurora.org>
>
> We're only adding BCMs to the commit list in aggregate(), but there are
> cases where pre_aggregate() is called without subsequently calling
> aggregate(). In particular, in icc_sync_state() when a node with initial
> BW has zero requests. Since BCMs aren't added to the commit list in
> these cases, we don't actually send the zero BW request to HW. So the
> resources remain on unnecessarily.
>
> Add BCMs to the commit list in pre_aggregate() instead, which is always
> called even when there are no requests.
>
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> [georgi: remove icc_sync_state for platforms with incomplete support]
> Signed-off-by: Georgi Djakov <djakov@kernel.org>

This patch fixes suspend/resume for me on sc7180-trogdor-lazor. Without
it I can't achieve XO shutdown. It seems that it fixes the sync_state
support that was added in commit b1d681d8d324 ("interconnect: Add sync
state support"). Before that commit suspend worked because the
interconnect wasn't maxed out at boot. After that commit we started
maxing out the interconnect state and never dropping it.

It would be good to pick this back to stable kernels so we have a
working suspend/resume on LTS kernels. I tried picking it back to
5.10.109 (latest 5.10 LTS) and booting it on my Lazor w/ LTE device but
it crashes at boot pretty reliably in the IPA driver. Interestingly I
can't get it to crash on 5.15.32 when I pick it back, so maybe something
has changed between 5.10 and 5.15 for IPA? I'll try to bisect it.

[   23.708432] Internal error: synchronous external abort: 96000010
[#1] PREEMPT SMP
[   23.708451] Modules linked in: veth rfcomm algif_hash
algif_skcipher af_alg uinput xt_MASQUERADE uvcvideo videobuf2_vmalloc
venus_enc venus_dec videobuf2_dma_sg videobuf2_memops venus_core
v4l2_mem2mem videobuf2_v4l2 cros_ec_typec videobuf2_common hci_uart
typec btqca qcom_q6v5_mss ipa qcom_pil_info qcom_q6v5 qcom_common
rmtfs_mem ip6table_nat fuse 8021q bluetooth ecdh_generic ecc
ath10k_snoc ath10k_core ath lzo_rle lzo_compress mac80211 zram
cfg80211 r8152 mii joydev
[   23.708565] CPU: 5 PID: 3706 Comm: mmdata_mgr Not tainted 5.10.109+ #61
[   23.708571] Hardware name: Google Lazor (rev1+) with LTE (DT)
[   23.708578] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[   23.708597] pc : gsi_channel_start+0x78/0x1dc [ipa]
[   23.708609] lr : gsi_channel_start+0x4c/0x1dc [ipa]
[   23.708614] sp : ffffffc013d9ba20
[   23.708619] x29: ffffffc013d9ba20 x28: 0000000000000000
[   23.708628] x27: 0000000000000000 x26: ffffffc013d9bc20
[   23.708637] x25: 000000000001c000 x24: 0000000000000000
[   23.708646] x23: ffffffab00cb9410 x22: 00000000712dcf80
[   23.708654] x21: ffffffab486bc148 x20: ffffffab486b8a18
[   23.708663] x19: ffffffab486b8000 x18: 00000000ffff0a00
[   23.708671] x17: 000000002f7254f1 x16: ffffffeb3db6f344
[   23.708680] x15: 00000000ffee6094 x14: ffffffffffffffff
[   23.708689] x13: 0000000000000010 x12: 0101010101010101
[   23.708697] x11: 000000000000013c x10: 0000000000000000
[   23.708706] x9 : 000000000001c000 x8 : ffffffc018f1c000
[   23.708715] x7 : fefefefefeff2f60 x6 : 0000808080808080
[   23.708724] x5 : 0000000000000000 x4 : 8080808080800000
[   23.708732] x3 : 0000000000000000 x2 : ffffffab5089eac0
[   23.708741] x1 : 0000000000000000 x0 : 0000000000000000
[   23.708750] Call trace:
[   23.708762]  gsi_channel_start+0x78/0x1dc [ipa]
[   23.708773]  ipa_endpoint_enable_one+0x34/0xc0 [ipa]
[   23.708785]  ipa_open+0x30/0x98 [ipa]
[   23.708795]  __dev_open+0xd8/0x190
[   23.708803]  __dev_change_flags+0xbc/0x1c8
[   23.708810]  dev_change_flags+0x30/0x70
[   23.708818]  devinet_ioctl+0x274/0x500
[   23.708824]  inet_ioctl+0x10c/0x394
[   23.708831]  sock_do_ioctl+0x58/0x324
[   23.708837]  compat_sock_ioctl+0x238/0xdb0
[   23.708845]  __arm64_compat_sys_ioctl+0xcc/0x104
[   23.708854]  el0_svc_common+0xec/0x1dc
[   23.708860]  do_el0_svc_compat+0x28/0x54
[   23.708868]  el0_svc_compat+0x10/0x1c
[   23.708874]  el0_sync_compat_handler+0xc0/0xf0
[   23.708880]  el0_sync_compat+0x184/0x1c0
[   23.708890] Code: 51286129 53037d29 1b166529 8b090108 (b9400108)

Note I had to pick a handful of other patches for nvmem to get normal
boot on 5.10.109. I'll send those over to stable maintainers shortly.

	fd3bb8f54a88 ("nvmem: core: Add support for keepout regions")
	de0534df9347 ("nvmem: core: fix error handling while validating
keepout regions")
	044ee8f85267 ("nvmem: qfprom: Don't touch certain fuses")
	437145dbcdee ("arm64: dts: qcom: sc7180: Add soc-specific qfprom
compat string")
	437cdef515e2 ("arm64: dts: qcom: sc7180:: modified qfprom CORR size
as per RAW size")
