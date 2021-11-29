Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D853462258
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhK2UoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhK2UmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:42:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A01C08ED6E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:17:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x131so17552948pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KemDiumlbcxPouh3L3ClUWKSB7PfWKN1Cz/0fv3QOaw=;
        b=UQv0URHo8nxtKCt7je9Sq9wTHqcHzxkUrRHbShEspIK7Q2+HbT9hOSF9OYliMQixPa
         J7omcX6U6626oz7bKQIPyuaiAk6pa+MNUMQfd9wVzpqr5CgNkcxkEhLcN8bFupEu3FOV
         NtsrjAC/343kTFrG6/WiKShdz/bf5AcOVy9dWIxPehQYL+MRRJ8+qR9OTO/3a2L2qaN+
         bB3jbveAWsbGg8OA9LsO/wrDmelR6CLYifZbdlk/MOeRwLF5oVmjhzcLpfTGmLolLJcI
         AxwyDax7GFz/ZNTZzg8znPdhuF3iZqXC+fxRxEb33evOP/jZ4NgT4VA//M/L37JGUWYo
         scDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KemDiumlbcxPouh3L3ClUWKSB7PfWKN1Cz/0fv3QOaw=;
        b=0k5fz7UvjbpRBHsZyF91ASoc4sgjm6TzOilnE+iHiyImtUdoPStWCae0KSG1NOZcJp
         /fjhQdHhhnG3X/tdWKjV2y3ZpkZdWds7W4gQfQ+vXoRVp4ogqqioqYkYYlR2qgp/Xvr1
         wiVm90Qk6sKz66+Ij+52kVe8YoLFGxHlH8OihJqTbxFFUmnk+IJ6Z/xZ2RhGrp+2UNw1
         qvhq4iVxHONSgYlaEboLEDlg9vzDTKc81ZfSrNsvBDsMdbEnJuI+kvXErv+21WF+xdCl
         KoZSpni/qCXctULMMszvbMWDrS++mKuojFNQROpH9RzZWi/S8Zd9eiOQ6+tHfEt3BN6z
         RdnQ==
X-Gm-Message-State: AOAM531lCA6cfTQGxiYE348/hMrIXXOVEI4VBhsAb3RKE+97FvWyMAFM
        bAz8KNYyNrptbH/hobl1cNqksQ==
X-Google-Smtp-Source: ABdhPJweaCP3RA/mL6V/zy5lv6zuvs50a2hfob+eURt3NfLVY9uZ16ZmI/IdVVr97/nlSBGArcLYpg==
X-Received: by 2002:a05:6a00:2188:b0:4a7:ec46:349c with SMTP id h8-20020a056a00218800b004a7ec46349cmr33274369pfi.26.1638206245157;
        Mon, 29 Nov 2021 09:17:25 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h3sm18914739pjz.43.2021.11.29.09.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:17:24 -0800 (PST)
Date:   Mon, 29 Nov 2021 10:17:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        a-govindraju@ti.com
Subject: Re: [PATCH 0/4] TI K3 R5F and C71x support on J721S2
Message-ID: <20211129171721.GA676889@p14s>
References: <20211122122726.8532-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122122726.8532-1-hnagalla@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Hari,

On Mon, Nov 22, 2021 at 06:27:22AM -0600, Hari Nagalla wrote:
> Hi All,
> 
> The following series enhances the K3 R5F and DSP remoteproc drivers to
> add support for the R5F clusters and C71x DSP on the newer TI K3 J721S2
> SoC family. The J721S2 SoCs have 3 R5FSS clusters, one in MCU voltage
> domain and the other two in MAIN voltage domain. There are also 2 C71x
> DSP subsystems in MAIN voltage domain. The R5FSS is similar to the R5FSS
> in J7200 SoCs, while the C71x DSPs are similar to the C71x DSP on J721e
> SoCs.
> 
> See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> Regards
> Hari
> 
> Hari Nagalla (4):
>   dt-bindings: remoteproc: k3-r5f: Update bindings for J721S2 SoCs
>   dt-bindings: remoteproc: k3-dsp: Update bindings for J721S2 SoCs
>   remoteproc: k3-dsp: Extend support for C71x DSPs on J721S2 SoCs
>   remoteproc: k3-r5: Extend support for R5F clusters on J721S2 SoCs
> 
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml   | 3 +++
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml   | 8 +++++---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c                 | 1 +
>  drivers/remoteproc/ti_k3_r5_remoteproc.c                  | 5 +++--

For all 4 patches:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

It was a holiday last week in the US so I'll give more time for Rob to review this (should
he want to) before publishing.

Thanks,
Mathieu


>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 
