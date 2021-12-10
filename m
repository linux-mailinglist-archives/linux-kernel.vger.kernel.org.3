Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC646F94B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhLJCqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhLJCqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:46:06 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B4C061746;
        Thu,  9 Dec 2021 18:42:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so8301875otl.3;
        Thu, 09 Dec 2021 18:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SbJRNPbKvj4MD6rtdoXt73eFOxvK0mr/fdigldvyUuk=;
        b=E4cZo74Bz8gfeZpTeV9Q8cUk8LeL7ixXprQEH7G8/oIiUzG/3NJzmwcVlMGHB2BM4/
         p9eBYmbDIYOxAJmKRd6GiTale4Ci0eM1FCrf98qnf2s6K7cDpolf8LVUIYNLDRnSUkDJ
         VWbVd1kerXwUSIoBrLg/dIYFzAgLM19xz1ONaGLW/kW4T0zoPeHFUwkyO7rb+9+MVRpC
         wrqKXaYUfxWm5TjPm8tZKzy9oUgzJf8fdW8w7EaRRBYSgdXjOMTQFe3Am4zi2X6OASJo
         FqtWipJMH8WMtQDF8aoJktGdJ4J5/PgIPSZ3UDr/uS3oUA8JveH6f5bKfmhC3lfTREkY
         bfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SbJRNPbKvj4MD6rtdoXt73eFOxvK0mr/fdigldvyUuk=;
        b=mZF9LuzoKUNWzq53XqaJFqZa3XnGw9+TFz0KGXXM0STihGJoXx9zsWJnY6swNyit41
         JTJWFcuuirTASDOkP8rAjkTG7C+XGdiUBJzETBZC40e9fLp0XeVMaiP5tESgdKbxjCbd
         oilYn0fl4/YSnU3E8ED14Oxv4U0qrC/lfadGdm65N+2yvX+hsg3Vsxw4IOkbLoHnHYeM
         MYtQTw/rTeo42p9hwHrvoogUYJh5J+T+GXBsMLGBqm632NvEv9Dq7HRHdCbtvF6uE9sD
         f/bXvwBcsmkOylMgl2pCzTZ/24d/9aLbOAgPGR45C0Cc59TaA8gLoml7kp4hdldi2uYG
         F4pA==
X-Gm-Message-State: AOAM532RaLzILNdS5rMdK0JN15OXKwRMIhvYAZWJ+4Scor/cGbDzGwob
        G8i24JsrvrX1HHj8an7hohWnTnF3G7cCt/Z+31Q=
X-Google-Smtp-Source: ABdhPJwunOt9nWYBn8+Kc7eiWgwG8swW0+5LKbwW2jvYDCOscD4tBPa4J0EclOk9WcV3QkJsJPgdRIkE73n57slX5hM=
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr9349256otr.46.1639104151595;
 Thu, 09 Dec 2021 18:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20211209095604.68954-1-alexs@kernel.org>
In-Reply-To: <20211209095604.68954-1-alexs@kernel.org>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Fri, 10 Dec 2021 10:42:20 +0800
Message-ID: <CAEensMzQ1keWthwvZ1yDozQ0r3BQ2PYb5bj_5FxXeYtAY2gmwg@mail.gmail.com>
Subject: Re: [PATCH v2] doc/zh_CN: add Chinese document coding style reminder
To:     Alex Shi <alexs@kernel.org>
Cc:     Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<alexs@kernel.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=889=E6=97=A5=E5=91=A8=E5=
=9B=9B 17:56=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Alex Shi <alexs@kernel.org>
>
> The coding style requirement for Chinese document is easy to be overlooke=
d.
> Add the request as a remdiner.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng01@gmail.com>
> Cc: Tang Yizhou <tangyizhou@huawei.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,
Yanteng
