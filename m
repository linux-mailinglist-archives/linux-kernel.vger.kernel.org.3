Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3552B71F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiERJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiERJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F214FCB9;
        Wed, 18 May 2022 02:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56F56169A;
        Wed, 18 May 2022 09:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ABEC34113;
        Wed, 18 May 2022 09:42:47 +0000 (UTC)
Message-ID: <695efb9b-a61c-085c-0667-fe7ca57d1ccc@xs4all.nl>
Date:   Wed, 18 May 2022 11:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/20] Add MFC v12 support.
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20220517125511epcas5p4e9a4e3c327771dd1faf0a50057a2c17b@epcas5p4.samsung.com>
 <20220517125548.14746-1-smitha.t@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Smitha,

On 5/17/22 14:55, Smitha T Murthy wrote:
> This patch series adds MFC v12 support. MFC v12 is used in
> Tesla FSD SoC.
> 
> This adds support for following:
> 
> * Add support for VP9 encoder
> * Add support for YV12 and I420 format (3-plane)
> * Add support for Rate Control, UHD and DMABUF for encoder
> * Add support for DPB buffers allocation based on MFC requirement
> * Fix to handle reference queue at MFCINST_FINISHING state.
> * Fix to handle error scenario on CLOSE_INSTANCE command.
> * Fix for register read and write for H264 codec encoding.
> * Update Documentation for control id definitions

Nice addition. Can you provide the v4l2-compliance output for this
driver? Make sure you build v4l2-compliance from the latest v4l-utils
git repo code.

Regards,

	Hans

> 
> Smitha T Murthy (20):
>   MAINTAINERS: Add git repo path for MFC
>   dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to new DT schema
>   dt-bindings: media: s5p-mfc: Add mfcv12 variant
>   media: s5p-mfc: Rename IS_MFCV10 macro
>   media: s5p-mfc: Add initial support for MFCv12
>   Documention: v4l: Documentation for VP9 CIDs.
>   media: v4l2: Add v4l2 control IDs for VP9 encoder.
>   media: s5p-mfc: Add support for VP9 encoder.
>   media: s5p-mfc: Add YV12 and I420 multiplanar format support
>   media: s5p-mfc: Add support for rate controls in MFCv12
>   media: s5p-mfc: Add support for UHD encoding.
>   media: s5p-mfc: Add support for DMABUF for encoder
>   media: s5p-mfc: Set context for valid case before calling try_run
>   media: s5p-mfc: Load firmware for each run in MFCv12.
>   media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
>   media: s5p-mfc: Fix to handle reference queue during finishing
>   media: s5p-mfc: Clear workbit to handle error condition
>   media: s5p-mfc: Correction in register read and write for H264
>   arm64: dts: fsd: Add MFC related DT enteries
>   arm64 defconfig: Add MFC in defconfig
> 
>  .../devicetree/bindings/media/s5p-mfc.txt     |  77 +--
>  .../devicetree/bindings/media/s5p-mfc.yaml    |  99 ++++
>  .../media/v4l/ext-ctrls-codec.rst             | 167 +++++++
>  MAINTAINERS                                   |   1 +
>  arch/arm64/boot/dts/tesla/fsd-evb.dts         |   8 +
>  arch/arm64/boot/dts/tesla/fsd.dtsi            |  22 +
>  arch/arm64/configs/defconfig                  |   4 +-
>  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  60 +++
>  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
>  .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  48 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  13 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  51 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 417 ++++++++++++++--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  16 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 446 ++++++++++++++++--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   3 +
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  44 ++
>  include/uapi/linux/v4l2-controls.h            |  33 ++
>  22 files changed, 1362 insertions(+), 202 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml
>  create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> 
> 
> base-commit: 3ae87d2f25c0e998da2721ce332e2b80d3d53c39
