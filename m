Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B904B4ACEAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiBHCJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbiBHCG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:06:27 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76DC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:06:27 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id 103so10674189uag.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 18:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfyiwO2AVOWs7V8ARFBIOI0IFCwTKGrQjrE/3zF6upU=;
        b=BXwarvKwCUk8uMCc7JUjUQo1GvGoWAv6TLEy/XyIauAvOc/9/61lE8sOKw/k/jB8uS
         UH+Bp59Wxfd4TGJX9WhfE2DjpucPvJ+lN9p/+i2XOLGlAX/tlG/9tYqEh+Qxo/VMYpRr
         h8AlRQ+a0nNh3fKMTSLj1ENIQSuyiIgL5A55s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfyiwO2AVOWs7V8ARFBIOI0IFCwTKGrQjrE/3zF6upU=;
        b=fQfNApMUGOsGRG+kffmZFAWmPSlPxSnlXTsboU4mce7cLZL3axMTRY9e3B5xTTNIq1
         ArRwucIXicD1OSjhqSoZjS+7rxf15IhS4x7aHwZoRTSqTuDQvcEf3ayk3TUUYPrOMldO
         xAW0p5XByYrBYerqrfghrz3O5ZW6H4vNlGR1ErDQB1PEMg3P0Lj71qYs1VOTIQrZMWnv
         kckuBqvhqRWiKBGljdvH4wl1Pe+XIqX7WIn8UskX6TJWncvH/9VJGz4OxLh0CL4jeE0u
         EVAAddsqG+CLb1OnUB+QF8Jo/6Z0jnwgpXVCPCIY+38F9gJzWum+hIBU6ul8K8Q6MyC+
         NwvA==
X-Gm-Message-State: AOAM530eJsAlyl97KEZzr5Wq2mjHilsFyGoU3fUroDbejt0z57eiDszP
        4bkVL4io1B/mH8MQredTixpM07aukg4036Vb1EYq8g==
X-Google-Smtp-Source: ABdhPJzZii52HRAKxoAOaCOsULJSpqRaRBcmWqyFYN1WC42KxDRVsTykmhKtcTYTiJdMuY6EUdFhEusq8xkOEm9SVcQ=
X-Received: by 2002:a9f:21ea:: with SMTP id 97mr866652uac.2.1644285986126;
 Mon, 07 Feb 2022 18:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20211006224659.21434-1-digetx@gmail.com> <20211006224659.21434-4-digetx@gmail.com>
 <YWimShkkxkR+bQLK@robh.at.kernel.org>
In-Reply-To: <YWimShkkxkR+bQLK@robh.at.kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 7 Feb 2022 18:06:15 -0800
Message-ID: <CAODwPW-2othAhTC9a_joBdHScA86iqs-FkZJZDrK5LxrJm8F8Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id properties
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for only noticing this a couple of months too late... but
this patch added the same thing to the "jedec,lpddr2" bindings that
were previously added by
https://www.spinics.net/lists/devicetree/msg413733.html to
"jedec,lpddr3", but in a slightly incompatible manner. Should we
adjust it to make them consistent (two bytes in one property, rather
than a separate property for each)? Or is it too late to change that?
