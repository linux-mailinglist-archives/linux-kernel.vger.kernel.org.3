Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304A487ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiAGWOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiAGWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:14:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DC6C061574;
        Fri,  7 Jan 2022 14:14:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j21so27210142edt.9;
        Fri, 07 Jan 2022 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SySDfXOcDDxrxdLlLmdKDsi07wKtcEMMXGppknRGrbk=;
        b=QXF3IO5zOQty2LsLhkAjI+1Ed7n5kUIhbHd4d9nM8uYhasFHC/ZKIivnMX4GzrXxcy
         Bp5VHzAbuRdgKl85GD2iC0lv5n9gabLxH4zJpJPaUbNQQ8r31BGGB3fn8cLPUzWAmmNu
         FzCfShoplLGN01S01f0Aw8ayN1UifhovWLOK1EXS86yt9S2x1QLnYCqRKDzkR287aBLp
         Z5tue5rIyi3RKW9YDDsaTj5CYVE5KS4xznc4oO26Pau35D48nQ7IdcSlrxB7HmauUd4G
         7TFiLFioRbQmLQnYNWhnhG8tzA3MwdRnBujwDFNeidnBSLGf6rMln8BQd6y8A31zIClG
         Tcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SySDfXOcDDxrxdLlLmdKDsi07wKtcEMMXGppknRGrbk=;
        b=kz0872F+ZX+bwx8p+CBh7YldD9Zs/msZbmqVT5kAI/HXscYYyf47gWvlcjrA3EQp6r
         +EWIpbxy6Ftyfm01UUmlFFG2od38Fz4agIaBvY0jO6zs79OcFGhXa5JN+dnPUc7v4Dpi
         QOu7R4Y/bxUt3F+1SoJK7Q5wOoQegzovQngvQM5k6g2JOpTdxHwzYdTws0Q4eNhUQ4Ff
         GgWuY7GAJmeX/bNTvzOHSTp/v/H90bxQ7eBmRy6TyUvkoW8Uhw9xDK6FD3TyIqo1Cotv
         xO8dD1hBzzcrHgYqLF8JUmCgYqMdKl48OeTMPZBGoS9/56MeVZmwrFw20kHeDS+TFi2m
         cOnA==
X-Gm-Message-State: AOAM530XdV/hiXdjfOelHpUDVNUT/ihLfCOGeFuwMuKWi4jCP9OUmz9R
        b8mUBVKP/N5RpcE7Jth1gWg9gaw3zi3sO9j/KNo=
X-Google-Smtp-Source: ABdhPJwAVQUd7nG/enEXRg1iURonC7ksnQzp9JOzzkBuRvOF7MWlM/7EzXIRmvQCrE81lA1p/W6+VAkq/sYpAGsCL3E=
X-Received: by 2002:a17:906:b89a:: with SMTP id hb26mr9338135ejb.147.1641593691749;
 Fri, 07 Jan 2022 14:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20220107145515.613009-1-narmstrong@baylibre.com> <20220107145515.613009-3-narmstrong@baylibre.com>
In-Reply-To: <20220107145515.613009-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 23:14:41 +0100
Message-ID: <CAFBinCArnZ8XtaBtWa0smmPTc-sHvAdD7_-3iTywxUJ08-uyMw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: display: meson-vpu: add third DPI output port
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:56 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add third port corresponding to the ENCL DPI encoder used to connect
> to DSI or LVDS transceivers.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
