Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F9656AA53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGGSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiGGSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:17:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B52A963
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:17:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n4so14566812ejz.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSMXSdyrhgxe/LPeOG9nwUhQ7bCN6L6RT7Z5TEvSX/k=;
        b=JCNjsSHGeIt/T9GRSU4+KoOf4kHWc+fTg9gE2OTI8ZhDBr/Q7oCXYPkRYVYUVZyGne
         XukdokHNmuNj4N0/jjkqnmwPTOYKzh6WspGHl1mffSUqDHiNMERPBqQnZov9/qk8+jqr
         wsJAf2a7Gr38RVsl9okaxE0FcZ93spRUaXiqJJ7MYOqiYKFi3X2NHqARrMEH+QSo7SZ/
         3H6zfhyAu5YN/F5+xok0AQuN4lUBQqT/eEp4YwSJ4UNXsk2O3wERi8lfVQ3u/ZJ2b7Jx
         2SHWu1lTqP1NZDnNcNsW0b8zVR0ourvq4u58yE/ZNQzmqk+hHCiAmEke4jyg5n+CcIIi
         5Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSMXSdyrhgxe/LPeOG9nwUhQ7bCN6L6RT7Z5TEvSX/k=;
        b=fzU15keiFYxSW+eTh8N84nxP4g+nRqxDKr/J8NQPakYvTEzVHmt7fOXSsVCp92rWT0
         i//vBnr22ZYcp7HO3ooO8nBL7Pk9YOW0qwYfDFMogsKa50EWRHna6ECQUyaXiGDXwqBw
         /Dej1FidX6Z7oh7TP60QHJcJcUDccdRFAws9QIchOTok1NZuPE9EogS1LVfHRMn64JkJ
         LYiP+g46okE1MM3f91QGGHMhHyKYmQ58WkIEiNvy1nci1Unf7rHErq0ci1EVZ5kWSbiC
         e0Vl9GWyX93YTIyOv2KPAuOUoUMudELYRi7ul2Hl9RGqBZg2pa8uz2vQdFvOkSN/GQhk
         KAmA==
X-Gm-Message-State: AJIora9ElXIuiVJH12U85ZJCeDKxpFRrPjMs+A4U9GKh89GuQDlQDoig
        SXBoP2xqFI4pFgYgJEOPO1Q/XJ1fUktfb/CNPFQ=
X-Google-Smtp-Source: AGRyM1uKhskxc8ShQ8HBDSEUOs9v5bJUfRFy8vHIbrZPDlA+g5jVfZKGLahYkwBWgTJefRsXToP8LLkYvfuDAxYz2mk=
X-Received: by 2002:a17:906:dc93:b0:726:a75b:f60f with SMTP id
 cs19-20020a170906dc9300b00726a75bf60fmr45516409ejc.564.1657217858197; Thu, 07
 Jul 2022 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220707013812.64057-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220707013812.64057-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Jul 2022 14:17:26 -0400
Message-ID: <CADnq5_Pe_bOh_=oFFu=zhyR=kXNrcVjwFLj0T5zrtwX_ntpTyw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jul 6, 2022 at 9:38 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warnings:
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:405 get_bios_object_from_path_v3() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:611 bios_parser_get_hpd_info() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:818 bios_parser_get_device_tag() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1599 bios_parser_is_device_id_supported() warn: inconsistent indenting
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index c332650b7048..6f514d92b401 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -402,7 +402,7 @@ static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(
>                 return NULL;
>         }
>
> -    return NULL;
> +       return NULL;
>  }
>
>  static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
> @@ -605,8 +605,8 @@ static enum bp_result bios_parser_get_hpd_info(
>             default:
>                 object = get_bios_object(bp, id);
>
> -                       if (!object)
> -                               return BP_RESULT_BADINPUT;
> +               if (!object)
> +                       return BP_RESULT_BADINPUT;
>
>                 record = get_hpd_record(bp, object);
>
> @@ -810,10 +810,10 @@ static enum bp_result bios_parser_get_device_tag(
>                 /* getBiosObject will return MXM object */
>                 object = get_bios_object(bp, connector_object_id);
>
> -                       if (!object) {
> -                               BREAK_TO_DEBUGGER(); /* Invalid object id */
> -                               return BP_RESULT_BADINPUT;
> -                       }
> +               if (!object) {
> +                       BREAK_TO_DEBUGGER(); /* Invalid object id */
> +                       return BP_RESULT_BADINPUT;
> +               }
>
>                 info->acpi_device = 0; /* BIOS no longer provides this */
>                 info->dev_id = device_type_from_device_id(object->device_tag);
> @@ -1596,7 +1596,7 @@ static bool bios_parser_is_device_id_supported(
>                         break;
>         }
>
> -    return false;
> +       return false;
>  }
>
>  static uint32_t bios_parser_get_ss_entry_number(
> --
> 2.20.1.7.g153144c
>
