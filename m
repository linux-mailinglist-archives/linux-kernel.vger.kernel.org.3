Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A5465BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbhLBCEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349422AbhLBCEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:04:06 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:00:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so37916092otl.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 18:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Vc3Qabf4OJ6DDpi6tStMrF6zk7jIEQOWBd5M271vBY=;
        b=bABFGGIVEbx5sfldUGK4NBiPfHgzxWifNufpKAFs1l0E1qYqdsAlU/JhyMaEnhc+6K
         Y6b5lJUlupOR+1BM5RRnglqibnnKS+t2tQZx/FXxW3FxlRieNNXWtYun+ks6koUSEg5J
         WdnURQqaR+vq1/2JDv1+YYtL31SKlzj/Dmw+2p4K3Tw4Yph8Q91p6o6mfwL5toGKDWrW
         wEu3JlpCWklxkPZJ1G8ZkSvNg5VcQ8fM5v+Fr4RkhZS05caCnmaGS/0L4Ly4XSAIDNHA
         dyesF+2tyOLnfRPCxf9k93eyRuyTe1dXAyIq/8EhCBQCKWcxXDjmmlww5+Ogepgp9MLp
         oFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Vc3Qabf4OJ6DDpi6tStMrF6zk7jIEQOWBd5M271vBY=;
        b=ilEdyigb4nsQjtzl5am4BZ5oXBeKA05qPYfA+zQseH180JgL7lL63xIUxc5jlP0aLl
         HRgePGmLkeuvWAbyThL2w7mBUjIgVrheJCpQflqCN4QTsWmfk6H6rK8BxkhmRI/EXM0b
         3lEjUbQgyGgk/tBmLJEJLuzgYLej0jwUxGteWdpiiWidjr45X541WhNmeX5jB9Ye/RCP
         SoQRj9zoJqcczQb3I0Lk+rKV94Rv6T4VDG6pFM6lcBR6pM4Tg4qT+atGwzMYlawbEypz
         ZjM9LS8w4lam9rDQXlaVyeCEE4ujCEylhwN21uI/q3naySCTV6Z8PE9xydDWqHmb6O1F
         92fQ==
X-Gm-Message-State: AOAM532bPWo31+X2bLQANDmA4fyWu/oc1qXKR4FfrEyh2AD8RZsSorkr
        uSchyTWURNEfOBgKU9xnh5RIesIFRtfneCRV7B3jKw==
X-Google-Smtp-Source: ABdhPJw8tTDONQzJQmG6nHE3AXUUTh7Sma4wvYXt/tgi5iHBWwjT1b2cetr3Ow9yWiJVbgrVCqBjocL5pcSyZdUhwiA=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr9139384otj.35.1638410444735;
 Wed, 01 Dec 2021 18:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20211110165720.30242-1-zajec5@gmail.com>
In-Reply-To: <20211110165720.30242-1-zajec5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 03:00:08 +0100
Message-ID: <CACRpkdYcv92JrxJcSbxkH=AXZDDph2y18hew16yhC=PaL_jYsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: convert controller description
 to the json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 5:57 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This helps validating DTS and writing YAML files.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Patch applied!

Yours,
Linus Walleij
