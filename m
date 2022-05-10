Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C617B521236
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbiEJKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiEJKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:32:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B451E3EFC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:28:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p4so19468973edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qB8tiSg9orpGv2oafVz+zb1jhV1wE750MfA0k2QQW9s=;
        b=rhth6SprFuXZRw9NUufEJzMkPofYa5+szGIs98AV0GVIbzsAA24w4QbdhAH0k6tNsm
         G9lbp93Qgq5wQy0+CFXT1fi5iMuYA4Cm9U/PxSd8amtshY1+WWPg3Zsj2ouQqfzpm3cT
         kgoHRoMvtjtr0hTCFuXrxFMAPcuVScNYCBHjhvwd+K12WtE868Zm28gTKB0PPjcHEMOT
         ul8LCqkXub36kGTu/xSmxsHDmFJH+vm3u7mGVS7NKOKyYshFVlM324rzPLNV2dHsG+Oh
         n0LVc+nwWpXvQhRwZyGWvq87SlHXW6mR5MmehPz78ndf2YvXFubXASGRbD0PBKSD9hJO
         nEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qB8tiSg9orpGv2oafVz+zb1jhV1wE750MfA0k2QQW9s=;
        b=pwPD5R5wXAILhhgoBxzCUo4Gn3hg8Wx0raTyn1J9g7yZyqoLK32302IO8gHDI2YEPW
         uyx9+zTb/iVimcOuZNIGVH10I7tGsqIBDfqIcyHpgAyCABL/054GrbapvoVSaxOyp0cH
         yMBMkCgTF3DkSGygXWgiyHWXZOUJGwxrfktCH7VFJ0ozZC8Lph0a8zZhid+CN/F21geW
         mrEvQd429swfMep8RWDpZVzp+D8E+2kj+YBSQXJ0w1Zf94IpC29kYYIDt57YASi2aRLP
         3GrlN3drcFkDtmkk6/+twS5SZV9zC35TfPbWxewMlCVvmti3aL65YTY+Ltaz6WgsiNwK
         VAGQ==
X-Gm-Message-State: AOAM531p4H/15/3+jHvs83OUVQJ+ytPWlcw0F4mqhbZ0lcwlMG9P1OvS
        PZC+IHBXbRvH1+/QEnrFwb1gUw==
X-Google-Smtp-Source: ABdhPJw5CAaM7D9q3+CFzPibPNCbcA7gMgHTzab1tVA8q065CZ3vhqKEUGpu1+K0yDXGbet+UCoR+w==
X-Received: by 2002:a50:ed13:0:b0:426:4939:45a9 with SMTP id j19-20020a50ed13000000b00426493945a9mr22748001eds.303.1652178495995;
        Tue, 10 May 2022 03:28:15 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qr48-20020a1709068cb000b006f3ef214e13sm6051348ejc.121.2022.05.10.03.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:28:15 -0700 (PDT)
Message-ID: <1c3fd336-1450-9b68-df81-2f01cc2ba32f@linaro.org>
Date:   Tue, 10 May 2022 12:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com>
 <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
 <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 10:45, Rex-BC Chen wrote:
>>> +    soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        vdo1_rdma0: mdp-rdma@1c104000 {
>>
>> Generic node name. dma-controller (if it does not conflict with
>> dma-common.yaml schema)?
> 
> We don't understand what dma-controller you are referring to? Can you
> help explain more? Thanks!

Use a generic node name, as Devicetree spec asks:
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming

model. If appropriate, the name should be one of the following choices:"

I proposed dma-controller, but feel free to find better generic node name.

Best regards,
Krzysztof
