Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444724A4949
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiAaO1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:27:15 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:35777 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiAaO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:27:13 -0500
Received: by mail-oo1-f53.google.com with SMTP id p4-20020a4a8e84000000b002e598a51d60so3257081ook.2;
        Mon, 31 Jan 2022 06:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVSaVxDORTFSvkH7r+avQcGLbthfWsafYf2hEJH7UWY=;
        b=1Nwuw7Nlp7WopZbC7guWzolhP0xSwYXymaX9sd2U1AzZFPM9RCNli4WOkmpgrqNAye
         YT/WxwfIj5fe8Xvn4PUY2DnGKsLIW8T7O+GCTocg533hTnhHnncAAgF1gyiHt2J6o6oN
         XaeTVnWAcIqzfn0z3V9qBaJ6JUwaNKjx0kAesD+vpJmqpFozf68MamcNk5Nvzqpev7e5
         jCxvvwr4LKSqWXW2/zAGXx9NS5Py/IKjfAelYXPMcSnJE7yAwiLLUB0AVdEdB/1k7oFU
         vipzMs0X1XobrddRSkXD1YpyaQ9EWGl8v+Byi/YhJqZjILEVBIiKaAXfAnG6ndCclCmU
         eK0w==
X-Gm-Message-State: AOAM530INn5FoMWUi92fRXdjBRCf1zp7stEAdUDnYB4ldUAr+5J3Swmz
        qXPJKYka1VBu8HzqFd/+Ig==
X-Google-Smtp-Source: ABdhPJzWraRGq7BgWkZ0iBlhnlBkkc6X3At8CSL892iiZw9aZSPrzL8F5R8iqfjhIc8Jo3mCprELLA==
X-Received: by 2002:a4a:a5d0:: with SMTP id k16mr10254233oom.48.1643639233155;
        Mon, 31 Jan 2022 06:27:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o12sm14534842ooi.18.2022.01.31.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:27:12 -0800 (PST)
Received: (nullmailer pid 226419 invoked by uid 1000);
        Mon, 31 Jan 2022 14:27:11 -0000
Date:   Mon, 31 Jan 2022 08:27:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: remoteproc: ti: Add mailbox provider
 nodes to example
Message-ID: <Yffxv491pLMJ5K5R@robh.at.kernel.org>
References: <20220119181053.3846613-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119181053.3846613-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 12:10:54 -0600, Rob Herring wrote:
> In order to make the 'mboxes' property in the TI remoteproc examples
> parseable, mailbox provider nodes are needed. Normally, the examples
> have a __fixup__ node which can be used for determining each
> phandle+arg entry. However, for this binding the arg cells contain a
> phandle, and the __fixups__ information can't be used.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2: Fix the example rather than changing the schema which was correct
> 
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml   | 8 ++++++++
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml   | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 

Applied, thanks!
