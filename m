Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4355B46AD30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358648AbhLFWyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:54:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44978 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358484AbhLFWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9EA50CE13D5;
        Mon,  6 Dec 2021 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37D5C341C6;
        Mon,  6 Dec 2021 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638831047;
        bh=/m8B7N3jn07JULFSJmfIN2cB4DvMqUf+Q2gtsAi4WYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3QYj0WmJh35iA/2aBRqyocQHyfRqeWsaer8cRiFNQKHd2o/PymZHP9BXeXn7alCf
         f8PLNWMRpxdT0t7xXVJWx2Jtx4zV0xoVSKVvlsPbLfhzP/nIzFck4Wv2smi16kMM2E
         6qdaCS10soNluWvwRIGyCuAc/CU5a0jZaJjY2Y35FgxhrY066IixTTVQrwKkaMURbB
         FJYmF3HLKWcL1w6v2xYUSZoAgs6tesvcXH6j7TQT+yaEtxxAZv89JOmceUlVxW7hRM
         6liaOFMQjDH2NLlAv0A5sKU4+5Qp6d+ruCCXPoyzRfSC4IKYRw/VKvnNTi7rAs/xiz
         nvTKh24U509aA==
Received: by mail-ed1-f52.google.com with SMTP id g14so48696069edb.8;
        Mon, 06 Dec 2021 14:50:47 -0800 (PST)
X-Gm-Message-State: AOAM530/mPupjs6QO8HYHFTyxRWLK3jU5RYmk8OPBfFe8CUO0RUc7mcy
        1ubgbHxlLFglPyb/Aj74UjB8auRPOEaplo4G4A==
X-Google-Smtp-Source: ABdhPJzQWjlsdlKnpjt+Djq9bVfhZhkqKmJUQQIFwENFEOID1iyokEcVWDrEBcnv1aslpxs8xFAfwX5TU/JaN2Ay9FA=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr49050471ejc.147.1638831046133;
 Mon, 06 Dec 2021 14:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20211202063216.24439-1-zajec5@gmail.com>
In-Reply-To: <20211202063216.24439-1-zajec5@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Dec 2021 16:50:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
Message-ID: <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
Subject: Re: [PATCH REBASE] dt-bindings: pinctrl: use pinctrl.yaml
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:32 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Also fix some examples to avoid warnings like:
> brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pi=
n-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'

I think you missed some. linux-next now has these warnings:

builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/brcm,cru.e=
xample.dt.yaml:
pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match
'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/=
pinctrl/brcm,ns-pinmux.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,ma=
dera.example.dt.yaml:
codec@1a: $nodename:0: 'codec@1a' does not match
'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/=
mfd/cirrus,madera.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirrus,lo=
chnagar.example.dt.yaml:
lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match
'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/=
pinctrl/cirrus,lochnagar.yaml
