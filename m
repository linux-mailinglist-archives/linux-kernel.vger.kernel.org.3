Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377EB565DAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiGDS7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:59:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE26467;
        Mon,  4 Jul 2022 11:59:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 91B905C00B2;
        Mon,  4 Jul 2022 14:59:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Jul 2022 14:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656961170; x=
        1657047570; bh=F5nGqDVFT2QAl9raw0kYO5IPENgXXLfXR4vGd0m2UgE=; b=S
        GWb3VNgBuFI+LzQ130jHv65ZXwAf93X6brKPo50RhylJOKQ3g5IPCv1eHe0dPJ2m
        gv2+SaG+EA0hAyp/GlE5WxxXFQINQrkSDocf2MjWcECNThQRNT98jzEaJAMa4inR
        Nz56/gjx20GJlZO4IQCvA9A6GU6H5kecJFz15Cx72e3MqoZl0xdOMANvmwXDN20S
        mkrJ5N/iVgYzGPEEInxysHtOJJXuBSvleaQqZ7RK13b12AXvuzN827T936NqMmLM
        GMZwn5GMIb7AH60TCsgc84OM7qd42QXKmOx7lc9jpjVRR/Mos3DCMBPczNnf7gRX
        pL1xo5kBIoOseKuCLgQKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656961170; x=
        1657047570; bh=F5nGqDVFT2QAl9raw0kYO5IPENgXXLfXR4vGd0m2UgE=; b=v
        EtquaKUde5G9Xko95UNgER955jTmkZNlhs4oO+uPJNEN4wvtwUWg5/P37HQQXZc2
        pz31KRHLph0PmZbnF3ne49v5Bx0qSXavEg/vUoP5NrV6lk2tDTdgOm6nNCiMAeFz
        1viNexFarGcFYXK9GF6ZeCPSGmPbKA4ug4JgH6Uboj8Ow8Wp1lVmM7F6JEtQH1EJ
        Wg0+evFYOE49x7i9Z97IgHKEVGxquvGbw1F2n2FBTbPbQp5MPGsQZQu7nwLpIItc
        UZmHUgzRqTRvXDwHTMR/SlhY64OvEDPaPpcp9DwS+AxOGjenqrFhK8YTa8S+4mFb
        8IdhvnUyNruQXAL/sq64w==
X-ME-Sender: <xms:kjjDYiQxDScMgjLBhdVZymGn9ASzaTUkWpUR2QndQT-44Hzm_rt4VA>
    <xme:kjjDYnxg6kfkCFsKSn4c4EB3GbgRsBINqE_vCPeY3VnlfeVvk9fDg8yp8QkSfY7vO
    VpUXdsftf-Yo8Ugew>
X-ME-Received: <xmr:kjjDYv3UKqMB-4tW5D8AT4Jbe6Se9xGtITVh2oYyfYyHw1dBLVXHPwks3s9e03JSkxLnikH9YPXIs_9d0yb7NiTq0ziBkNoD0Cue_vo2sf4XCxQc1mlLgo5NwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehledgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:kjjDYuBpt_hL62xi7sHJUUIVbGavVJRSeN4Uo_NWukIP-b4ojuCKBA>
    <xmx:kjjDYrgY-8XI_1BWi1il2Od0_5jLhgxHYT4U0SDIk9UvECPkIp8FFQ>
    <xmx:kjjDYqpypb5FqgWMwpOxstMBsP09Nk-h7yxkl0PrwSkKmxcKJWjCkQ>
    <xmx:kjjDYgZJuf5d-Iblhqr-aditUvn1iSp3B1crGDRCETR0M4X9VBYhvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 14:59:29 -0400 (EDT)
Subject: Re: [PATCH V3 15/20] OPP: Migrate set-prop-name helper API to use
 set-config helpers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1656935522.git.viresh.kumar@linaro.org>
 <bbd8f1e7508a9c66028ea1d80fd86924256fdb64.1656935522.git.viresh.kumar@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <500bf605-a30c-8092-631f-0f9a623bfb74@sholland.org>
Date:   Mon, 4 Jul 2022 13:59:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bbd8f1e7508a9c66028ea1d80fd86924256fdb64.1656935522.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 7:07 AM, Viresh Kumar wrote:
> Now that we have a central API to handle all OPP table configurations,
> migrate the set-prop-name family of helpers to use the new
> infrastructure.
> 
> The return type and parameter to the APIs change a bit due to this,
> update the current users as well in the same commit in order to avoid
> breaking builds.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 31 +++++++--------

For sun50i-cpufreq-nvmem.c:

Acked-by: Samuel Holland <samuel@sholland.org>

>  drivers/opp/core.c                     | 55 +++++++++-----------------
>  include/linux/pm_opp.h                 | 23 ++++++-----
>  3 files changed, 46 insertions(+), 63 deletions(-)
