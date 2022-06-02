Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849B53B955
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiFBNEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiFBNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:04:49 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E31E562A;
        Thu,  2 Jun 2022 06:04:47 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id p129so1784999oig.3;
        Thu, 02 Jun 2022 06:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUqVqrJP8hpf0KLUEUTHZhE9DaMt/u7RwjOLvmeIQa4=;
        b=Pnbg8vGmvzVRkC4QBbxdVwNMaQzNRdA4ozUl0rOMAqgkoAfJbpJm0mIDuvbgfPr11Z
         CcaxSrWEEw0Ng8iJElLnvAsHo8cSkaLBrIj6P7ecW/pmO7HyM9q164LVBimOnFikRuCw
         5jfTUpRqowFpvUnnTUzDOAFtVsNkmXzThW6ouEBULp7UdgjjlX6denyvW9J2maoTWi5E
         tw4dYQ58s/+Cct+JVXvIE9PepxUeGGNASQWNwfWjVMU038FQpprzdzgb2r63bFkrmtRo
         8vm8Vcjnh1KYvpDi4WCPXTGGYxcQn5UCR+flYC77+/UYCVftzJXwPWQ5Bk8SWd0BnFAy
         tZ5w==
X-Gm-Message-State: AOAM530suulfv8vT6U0LjGpn6+n4IVIZ7UCHxBq5xzFMKU+r9XbfLxQG
        AJLrQQ1+nWXpgH2T560nOw==
X-Google-Smtp-Source: ABdhPJzCakeKGnP2z4QHnJMY/hAq5LuT05CQuOiettY954ZRY2sgkP4PmgjaCJ5DPW8q6LFib5tLvQ==
X-Received: by 2002:a05:6808:1407:b0:32e:1ad1:2d4 with SMTP id w7-20020a056808140700b0032e1ad102d4mr5048424oiv.235.1654175086977;
        Thu, 02 Jun 2022 06:04:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d6-20020a05680813c600b0032bbcbd59b4sm2338696oiw.17.2022.06.02.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:04:46 -0700 (PDT)
Received: (nullmailer pid 2106788 invoked by uid 1000);
        Thu, 02 Jun 2022 13:04:45 -0000
Date:   Thu, 2 Jun 2022 08:04:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 2/4] dt-bindings: usb: mtu3: add support 'resets' property
Message-ID: <20220602130445.GA2106738-robh@kernel.org>
References: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
 <20220523090449.14430-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523090449.14430-2-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 17:04:47 +0800, Chunfeng Yun wrote:
> Add 'resets' property to support IP reset usually by top pericfg.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
