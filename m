Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083CF471A48
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 14:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhLLNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 08:03:45 -0500
Received: from ixit.cz ([94.230.151.217]:43348 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhLLNDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 08:03:44 -0500
Received: from [127.0.0.1] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E3EE224AF0;
        Sun, 12 Dec 2021 14:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639314222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKBncOiJrAHylK3jJuEOyh8VWLh2/06IDh/2G+b3Wfs=;
        b=MJHP/g7q9tdOQEMWaPGFSmG6dQik3NCZKybeE1k3hiD8mX3PTwBxnCsKS2fgvxXbcssenu
        C7SdAtf3HXzHjn0hxcBrNJjtR4hJMAamfEbIr77yaEcqKsf43xwl5n248roJEPfFKpNILa
        PT61dew0EOqa5d5KOu1TrbQqsOaJyv0=
Date:   Sun, 12 Dec 2021 13:03:40 +0000
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: misc: fastrpc convert bindings to yaml
In-Reply-To: <YbPIM9OXyuU5hfHY@robh.at.kernel.org>
References: <20211208101508.24582-1-david@ixit.cz> <YbPIM9OXyuU5hfHY@robh.at.kernel.org>
Message-ID: <7A333484-F1D4-4D0E-97D5-6A40DEC44BFE@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, since this is a subnode, some nodes are not converted yet and at leas=
t know it'll bash about iommus, qcom,glink-channels and qcom,smd-channels=
=2E I can change it to false, bit it'll print these additional warnings, un=
til other binding don't get converted=2E

David


> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: true

Why? What other properties are present=2E

> +
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true

Why? What other properties are present=2E This is generally never correct=
=2E

Rob

