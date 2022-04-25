Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1E50E2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbiDYOJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbiDYOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:09:09 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9825C;
        Mon, 25 Apr 2022 07:05:59 -0700 (PDT)
Received: from [10.0.0.209] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B761B2007F;
        Mon, 25 Apr 2022 16:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650895557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzzpAD5S0leawcwC8SUp83/bhKkhf4LJmp7cBJfQdME=;
        b=XQnZVrDKNKWF8jIPrC4gratZ6yMzIvjprTeXGN1lcY1Hxgnc2z76/Chkb9YfZiXt3TyuOr
        P224uakTiUeks8zOcQ9ZWfY+GL1xLUmubfN4SAGjVbuMeg2eIsfvjy2RoL/uEiR3aOWBGy
        oBnOBb776rCWyMzPTaYx+iFDO1StgTE=
Message-ID: <33da014b-bfb0-a39f-aba7-f469fcb5cfbb@ixit.cz>
Date:   Mon, 25 Apr 2022 16:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: qcom-ipcc: add missing
 compatible for SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220425134717.55418-1-david@ixit.cz>
 <6f72be3c-c907-bc7a-6b64-6becfc76934e@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <6f72be3c-c907-bc7a-6b64-6becfc76934e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 15:51, Krzysztof Kozlowski wrote:
> On 25/04/2022 15:47, David Heidelberg wrote:
>> Adds forgotten compatible and update SPDX header.
> You need to explain what is this "forgotten compatible". It's to vague.
Forgotten by someone who implemented it in driver. Hope that clarify it 
for you and possibly other readers. Btw. qcom,*sm8450* compatibles are 
widely used and fact that `make dtbs_check` noticed it missing here 
isn't suprising..
>
> The SPDX update lacks answer to "why". There is no reason to do it, so
> please explain why it is needed.

Please read https://spdx.org/licenses/GPL-2.0.html (red colored text).

I personally encountered situation, where usage GPL license without 
specific `-only` or `-or-later` caused unnecessary confusion and 
uncertainty.

>
>
> Best regards,
> Krzysztof

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

