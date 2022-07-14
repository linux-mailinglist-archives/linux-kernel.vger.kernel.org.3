Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556275748BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiGNJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiGNJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:24:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D743315
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:23:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a9so1780331lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AUwzY3hlYC7IOrVrAzCvOOC6OujctZysyq2jJzvcuUk=;
        b=C5Z3mdOYRDTVVvsiHqfZ6rD/xDQOx8TUR3cPZucQxhSZnK2fM4K0NTcMUF5We4VT64
         jR0L8Nh2NeYY2wLqJN1o33HDpDycP5hTQIWe0W5ba5WpUbpGVUwJoiqtD9SKcWwGXqWA
         UEsg4YUjO0fdlxky83xAnfZiKZeNEbf2GD3b9rS1NEP/vp7vioX6RdP4qQjS+aXySML8
         VyNW5oEHzL72rfHm7/k30o0nA1VnjMnrv1WsLq2PytqbeKOms+Bd63A9VLNwHPAg1AWV
         y0skf/9cdfqujdt7o0offypS3yqXkpaFmWOy2CFuptYFWYCInIljlSqocmmsQNoBdN8E
         gs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AUwzY3hlYC7IOrVrAzCvOOC6OujctZysyq2jJzvcuUk=;
        b=qoo5ehi1aAwJ4v5J474dgcJnv3zkzhPXdCgBKUOqX3c9ESBIUH67kSlpOx/C/8ggeG
         8j76HmUisQ9bb9USTFUHX5KsxuXF1NhI6fmhl9rSpaoYeSOEnX/d2oztn1/1Qadu3StJ
         GhwO332eSLvzL/7XpwPDpRC3h68UxfgmeR9v+pBPPXEMZKkm+YZT35fNA/B5d11lz6OT
         XY+omuh7VgcrDTueJ1ux6X4NICrOb/k5KMr5h9GQeGmhG83zT3bAMUAeMY/3qr+KcC3u
         CAY2925ve4MLlfgv/6knIpCcBC3fkSeUWO6Qk9h6XRRISuyvRqkBSP5l5sXKk6CQqVDf
         meAA==
X-Gm-Message-State: AJIora/fcjjW3Jeo0qVfliLspN/reNWPGXhGoMobq0iHEjJF2eFgvFCN
        6DoruNJyO7ySdvfq/aVF4RzmNQ==
X-Google-Smtp-Source: AGRyM1vCFK8vQKfo8J+7uenDaDUFR82xnL9XfQLmxELjFt7++4DyEnRhG2U5pQj2yI9xMp+OlPlZaw==
X-Received: by 2002:a05:6512:324a:b0:486:a915:7b70 with SMTP id c10-20020a056512324a00b00486a9157b70mr4276112lfr.265.1657790599364;
        Thu, 14 Jul 2022 02:23:19 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id f8-20020a05651c160800b0025d5a4f53dasm175508ljq.65.2022.07.14.02.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:23:18 -0700 (PDT)
Message-ID: <ff111f4c-3820-8f08-ed5a-606d4a9a9257@linaro.org>
Date:   Thu, 14 Jul 2022 11:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 18/30] dt-bindings: phy: qcom,qmp-ufs: add missing
 child node schema
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-19-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-19-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 15:47, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
