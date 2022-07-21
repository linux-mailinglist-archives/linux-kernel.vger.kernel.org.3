Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23B957CCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiGUNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiGUNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:52:20 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E030571
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:52:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a13so1726739ljr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GcPhmjnt4mBJMLQ1FNkJPIrrpr8eJhEoBFrow43QJC0=;
        b=VkmgZ2w2AuIi0+CDBwutSnNBJS99bCNhKIPsKOfJTDGhM5pomY21eX1QPiJdxrcTes
         aQqWf6WiSSkwwKjED49nTeiZ5OITPAeQaFgQLQPmz2ypbAB8zJX78Be4BDLStFEpP5/1
         5NaBrkEXr99U8eWYEiloGRjnmIYEpTPHW6tWppTx2Ac0mcEcdQm3HH5JGgL7EFGZDO53
         A8716S+9EEJEqRjnRQ5Yv9XvPlsbNy0Aw/BlPIuSCeVls7LcdW+7ZY9awWvRMojX0f9P
         4vKQ/VAVTY7Dv1G72IR9BFAuo2a/sZ5g3undbqSMTfyFSKgGA9dRUOmIwB9EclJoYkVm
         wEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GcPhmjnt4mBJMLQ1FNkJPIrrpr8eJhEoBFrow43QJC0=;
        b=BCkwCihMvx8O/4U2CBidM2xr2QzaMpehM8rSn90CkUlJN2vTwb6iLZSo4cSVSmCsTO
         t02b2rlJ7C8unJytNa2PuxzU248kJJXKJ6f2UXjrdGUHri+t0i4gtkEJRFZYzV8mZXeB
         a4fLryLZ/Uyoab7fiQuaTPhd0GyMfKyPPVMO/QkDk9/BB3magfd0kzslwnlHPQdANc/x
         xNS5B2jteofyY2syfziyHs6VajIiYRzITNm/tZAhTObunKWheQ8MNPiVviJOjmjkCpvL
         e2SUFoLQd7TsTaEISkpgFMdjX+S4gVZdIe3mEd1jJ6nkjZGtEFOP+ylSEpUTy3SpAiXz
         GCyA==
X-Gm-Message-State: AJIora+Eu4ycZPMJY06avEuabLbRpBhKo3WiN8B8HVnj/9jsMU4d7dfS
        q7KqENDYq28lLzcHFvZYFHwtNA==
X-Google-Smtp-Source: AGRyM1taC5YGi07FufwEMt88CfMJZywf2kFdPNL7GAICbOmgQ7jsqQrjIPZnVBF1pcMwETgg0iQ//g==
X-Received: by 2002:a2e:96c1:0:b0:258:e8ec:3889 with SMTP id d1-20020a2e96c1000000b00258e8ec3889mr19318648ljj.6.1658411537193;
        Thu, 21 Jul 2022 06:52:17 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b0025d952545e7sm535271lja.12.2022.07.21.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:52:15 -0700 (PDT)
Message-ID: <eccdf3fe-69a0-1af3-8378-8fa41e37aa1a@linaro.org>
Date:   Thu, 21 Jul 2022 15:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] extcon: max77843: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20220721100711.15847-1-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721100711.15847-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 12:07, Aidan MacDonald wrote:
> Following recent changes in regmap-irq, unmask registers can now
> describe inverted mask registers where a '1' bit enables an IRQ.
> Because this implements the same functionality as mask_invert and
> is more straightforward, the mask_invert flag has been deprecated.
> 
> Update the driver by replacing all uses of mask_base & mask_invert
> with unmask_base.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
