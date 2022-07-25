Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74E580535
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiGYUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiGYUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D7220D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:12:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o13so450120edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLNtAH4ZVUtmn0ECdu7iuFAaapi+HL9I7pXxXmdck8w=;
        b=PTUrc6t1ic0HYfkNp2akyzJG2VcZ5pnZ+lxvTG51h33EEWxLes5a5mcyzuh8GlXTEI
         yo8GZ686GVz6FZxlheDXTD00px2WiBzEGXUVc3fP6KKIUqx9hqzx3IX6+peazAI/VF53
         VpnjVMpwAj4GXuZELDmhxcU3DlbL+hukrIdgletKPl1HnOyHba4SnYgLJpJ7JIGgQomP
         4EUUie+QxeJGLSXfIioN1ZFDB5i5+4bmnpO5DJZPdnDSyq5Beulsc3QbOUx7GIjZcKs7
         kmCm7RkD/cVLlh7P3IGq5Wg8Q3lrB3PM2bRq/GAZTxi2RKXCLjCZjhSvl0tAW8bdHa4P
         zdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLNtAH4ZVUtmn0ECdu7iuFAaapi+HL9I7pXxXmdck8w=;
        b=4jxfKhaeeZ+1nLFxYW+Hiup87hUXpgWGTIDtgTCHlbS/bgrapJflKm7wpWJ6e+ey1G
         YENEJyyvukp61Sgf/kksqRCgzGOJnatJczaaBb4IF3lzxtfWwGnkaWoJDXQM6/s+MrPL
         lR4XeAcH8QXBydU2SfDuXD3PmGvaJleOLle/W7GrE/ffljG7+6fsObcLFNQrP8F+D5ct
         YR0hImx7OMdJagZGJ6qO14wXAsRrbVipCc04tjJDQyzspidNVIUh8hZtLi9eSFLCeboR
         wpEwEh0i6S5ZHhC1YkyJYm6xCKw9g0hOSCsb+I274v+dTyptTFY0QV1T8259jAHlqpwC
         ppvQ==
X-Gm-Message-State: AJIora+QfSXKeMju7le3ILS2nnQC9FNzqpBL62oVVOWKERXUeIeG/KJY
        fjopKRwHwEFIhSyB5u0xmNOT62xnJj/pIlimXc1ow+LA
X-Google-Smtp-Source: AGRyM1sHgpidV9VnWISJsHLqj+Bvg1fR0OozJDV3Q4VSZSDdCPqA8td9X6oFEhicq4HYQEhGBzhJRgnpRhXt5xv8eMo=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr14751707eda.75.1658779959059; Mon, 25
 Jul 2022 13:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220724074150.17869-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220724074150.17869-1-wangjianli@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Jul 2022 16:12:27 -0400
Message-ID: <CADnq5_M0QnP+W83cSb-mpHNjrjnF9hS_e=PJ=QkEiof7Em=NPg@mail.gmail.com>
Subject: Re: [PATCH] dc/dce: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 25, 2022 at 3:23 AM wangjianli <wangjianli@cdjrlc.com> wrote:
>
>  Delete the redundant word 'in'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index 70eaac017624..f0b585caa28f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -322,7 +322,7 @@ static void set_video_latency(
>                 value);
>  }
>
> -/* set audio latency in in ms/2+1 */
> +/* set audio latency in ms/2+1 */
>  static void set_audio_latency(
>         struct audio *audio,
>         int latency_in_ms)
> --
> 2.36.1
>
