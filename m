Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D74B27C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiBKOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiBKOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:21:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B6D188;
        Fri, 11 Feb 2022 06:21:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id F2E6E1F46F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644589290;
        bh=nPecqjoPg/Wa/ujakqZuIp1Ml6tDHiENrm9NfMMwz70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C5NvHNXK9bE8RER/lY869+H+O/Yt8R1BpMU4xgQcZeGB15iIguUrs1cw7VnwAlo+i
         2pXXGi7w2gtK24JQHyU4IkyG5x7kmcbEGleynQxNzFHgn04ZWyJLhQXWYIseJFcKRO
         Dxjbvz/1KMFkHRv+gltZeAPyQZUMA9zlTTicR6yt/Z1AUBaZnlYm0w45fFQ1pgLrNV
         EyuhY3CTc3jIzPJh37J2Tg95V88aThGZ1MKezzF4mHauJpPEbdQcBfXC0y4zB6y+CD
         jN/C1n5ojpEYgBHCXwKGrm8z6qUExACmaU2U1bCUQPZQR5qGMjA8XZpIy9/EZeRFh8
         lYZ7qjRyCEfSw==
Message-ID: <fbdc230c-35f8-01d9-ae26-0bfbd92ffaa6@collabora.com>
Date:   Fri, 11 Feb 2022 17:21:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/4] media: v4l2-ctrls: Add new
 V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207141937.13089-1-digetx@gmail.com>
 <20220207141937.13089-2-digetx@gmail.com>
 <d986ab76a7c52a9a2ce62c1edb07f520c9df51c4.camel@ndufresne.ca>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <d986ab76a7c52a9a2ce62c1edb07f520c9df51c4.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.02.2022 16:29, Nicolas Dufresne пишет:
> Le lundi 07 février 2022 à 17:19 +0300, Dmitry Osipenko a écrit :
>> Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags that are needed by
>> NVIDIA Tegra video decoder. Userspace will have to set these flags in
>> accordance to the type of a decoded frame.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> Can you share here (out of commit) a userland implementation that was used to
> demonstrate the new API ? It does not matter which project (GStreamer, FFMPEG,
> Chromium, your_test_progtram). Should be fairly straightforward. This is just to
> be transparent.
> 

You may find all the links in the cover letter, please see the
grate-driver's GStreamer [1] and libvdpau-tegra [2]:

[1] https://github.com/grate-driver/gstreamer/commits/main
[2] https://github.com/grate-driver/libvdpau-tegra/commits/master

