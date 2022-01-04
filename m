Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA2484924
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiADURX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:17:23 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44592 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiADURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:17:22 -0500
Received: by mail-ot1-f48.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so48115765oti.11;
        Tue, 04 Jan 2022 12:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZe6h9IZ5mJFq2lPFq6YgGUpqZsfKEUO/x8BTCF7yN8=;
        b=UL+NF2DzGoPx9T6r89EPun3szbAXm4enh/yOH28Ls1SXLNlUslb107/lfOmxlbfwMM
         P+GhMo77OUPk2VDZV74dHrPUUiBwG2EObaUCXEdlBU9oY/pxZBMnWb58c2dt5/cXneUo
         Pd6ekwKa4DQh8DG3W70NzlBEsDJr+N48m6qU0Bs52P1jxvy6IhSZxlro/FYVEaVMnnqV
         SUkhFSb3y+xenXrPnIbNr/IXhD01JcgURx6R5pj7AUmlWxoXDmDufnESzCKDrI3oj1PB
         WxRWZe2Os9H7F2NF3ORcmNB/oDdRU9QlCZYRntuhG6KPCJguARCZKGntUCoXLEuwLiao
         jaWg==
X-Gm-Message-State: AOAM531mWgzQxsaj1bn9OHoRdoDMOsFtpM8nqeyAkpSSXlM/iLHQmaOY
        TMWxJwndVWa4EB4mjEZEPA==
X-Google-Smtp-Source: ABdhPJwmUKUS4CgC3yiAFqIrrdEqJt0bg69XyvKXXDZHS1Ii4fWEH+zKTJ0Inqnv4CrGY7/HgvOLhw==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr36314328ota.11.1641327441715;
        Tue, 04 Jan 2022 12:17:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i25sm7712438otl.8.2022.01.04.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:17:21 -0800 (PST)
Received: (nullmailer pid 1347163 invoked by uid 1000);
        Tue, 04 Jan 2022 20:17:20 -0000
Date:   Tue, 4 Jan 2022 14:17:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add OnePlus
Message-ID: <YdSrUB4FHyJjf/jV@robh.at.kernel.org>
References: <20211223141002.GA5979@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223141002.GA5979@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 15:10:02 +0100, Stanislav Jakubek wrote:
> Add vendor prefix for OnePlus (https://www.oneplus.com/)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
