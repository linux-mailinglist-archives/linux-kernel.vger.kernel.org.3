Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE8587AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiHBKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiHBKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:42:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8625EA5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:42:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y23so4831152ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I4j/8n4xnT8IIxFREv8EVE5ht/FmQ3Sa2fVspmFHrgs=;
        b=WlWfECukTPGkP4Bkf536Lob1Xti44nFeJQjqpE4Ra2PHlWsA6+9LCnxwCEImuYQ09U
         0004WLCS0bUFC3XMyks0LVW3xvNRtetWnd5sKlpzPTCP0jxPY6b8fFMVRAr9NSgICmrH
         DokgE4XNobt2R1S/z9slyF6ojO5wcJmAuvHqWBne+XAgbcSb2IP3awPAMS40Zh06djlS
         T3q28yqrIiFNnIjW+QWrb5a9JjYVmJloPUohQdplE2hUGOS1r/ezFnaK3FvMF5evL1sE
         J6bp03bMQ+zZcIVS1JviG6nkowMlpD4cCB6XPGl2/migNk3W7FthP83YfTE12yj8EBMC
         pcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I4j/8n4xnT8IIxFREv8EVE5ht/FmQ3Sa2fVspmFHrgs=;
        b=FiVw0NwrfFni0u99yUZ8hMoI2CLkWB0zDfs/3g3PT3rB+CxlXEbVKJ6XTw9E4piOQb
         TTwzlZUMl9wY7RA6lYkgE26XmC2h8rMvjQyNR76lXgUwJdAFts4eb2PaDP0FJQB+7oYD
         t/vioV4quhHXskTKx9nkQRL+8kHEscZeWNKwM4iraELHWfCZW1jNWvHcRIFc0ioED6h9
         ZeEKrD/S6s3NpbQ87zfAYJNKyTUGN7ARTh5k0Nhkel5lWTIWhap1tl48OrcnB3uH6Ume
         s3RG7RPieSmD2U0/7mAmLxCks3jLF/GTyyv7klTiWJE+SWKZ9NeCBKl70gsmhCeDPfQq
         hBMg==
X-Gm-Message-State: AJIora+7jaa5Pet7m/2yyvqglrVIRBQ8fC+fnP1ktMvgCVKCPnatUDW4
        DFyZ9DtwaDLXXE/Lt0KCTuCcbg==
X-Google-Smtp-Source: AGRyM1tzC68/tPz+QIxfLHnHPTZ4HN90ljcN5ErjCmRvTBEbuCD6n5ITyMIxxRm/Lk+IHzPxVafLDw==
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id h12-20020a05651c158c00b00250a23d2701mr6867654ljq.475.1659436949946;
        Tue, 02 Aug 2022 03:42:29 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c12-20020a056512074c00b0048af3c315efsm997083lfs.191.2022.08.02.03.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:42:29 -0700 (PDT)
Message-ID: <f693f007-70dc-a4ce-e586-a9d97c6f361c@linaro.org>
Date:   Tue, 2 Aug 2022 12:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 04/13] dt-bindings: regulator: qcom_smd: Document
 PM6125 PMIC
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <20220731223736.1036286-5-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220731223736.1036286-5-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 00:37, Iskren Chernev wrote:
> Document the pm6125 compatible string and available regulators in the QCom
> SMD RPM regulator documentation.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
