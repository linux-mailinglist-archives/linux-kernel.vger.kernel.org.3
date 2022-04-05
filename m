Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E024F23A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiDEGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiDEGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:54:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D68E19F;
        Mon,  4 Apr 2022 23:52:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso1605712pjz.4;
        Mon, 04 Apr 2022 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7IfAa35wZueQlpILhArIwdi5wof2d9MJ6JQOJ6J4OA=;
        b=onw8c5kd8hJ35SAzcgt1RqWuWR6arHwVGl/M8wLuE2vcT8dQyhaMkU8I3jNuuFsxGd
         DcDBubwjjpXAH8aSoSx/Z3IkZ21QIUlj36t6jipAbot+K89+n2FQpBkap2Ug5AnkmIhc
         /CGLJMmbHWZF9ZQtJ1gP1Q9deXtnfxIaeMCv5DijCPxLNxTuK328DBvSXC9Lr3wzkcK9
         u4WXqlojbhJWwpi40KrC3XIRnZWZSTFHpabaMUbjn08pOm8TQeAtu02RLBoZTZeamTvp
         7qVwuuGAPYAw41lg9dzTHU+IOT9YQ2iX1updMW4Caydl8s9YrbIEJFBU9yzgvqVE0/YK
         9paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7IfAa35wZueQlpILhArIwdi5wof2d9MJ6JQOJ6J4OA=;
        b=kW7G6wTXjKzsRoIOT15WfeSSQ83d/EJd435AyezeJuW725lszde1gFRGlqL/YPUDqk
         HqHDkE7WNsciACKN8AD13Skdi38kUDvqVoSricL3X860DbZ9ihGn1OsqC0E7DLxLipMf
         kkYhr7TZsnuet78ISQjM6o85gFOnDkRT+J5UsN171JOmGRhUnAcvJK0KmmGSbWkpIWTh
         5K/R2Plq/v8RGSqh1mqzUhWQCrb5MNTL6G7qCBC6UayNmeyr/AnftKOacNvrHhpxdttn
         fDWqYECOiZRQ5hcRFBibLtIj2nj17M/KBsAUkEV7//7lauD029x5rAh3bHPD8jZucwvz
         k6mg==
X-Gm-Message-State: AOAM530MN1BkiX3dKw/TpjXN6G9a/2X12MWqNKXC4I84V7JXwDtGA4lo
        q2q6t0BwJNmP03O0qff6uLc=
X-Google-Smtp-Source: ABdhPJxvIbFee2TMlUXRiklyU7vb3hK3lPsFxUfOrmMPVbKWPGW8xfAq6Yq2csylTpf2aLOYBw85zA==
X-Received: by 2002:a17:902:ecd0:b0:156:aa84:613c with SMTP id a16-20020a170902ecd000b00156aa84613cmr2004095plh.88.1649141559574;
        Mon, 04 Apr 2022 23:52:39 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00135100b004fa9df39517sm14709263pfu.198.2022.04.04.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:52:39 -0700 (PDT)
Date:   Tue, 5 Apr 2022 12:22:33 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <20220405065233.GA61175@9a2d8922b8f1>
References: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:37:24AM +0200, Krzysztof Kozlowski wrote:
> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> address rejected: User unknown in virtual alias table), so switch
> maintainer to Bjorn (as active Qualcomm platform maintainer).
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add only Bjorn.

That means shall we keep Bjorn as the only maintainer for other dt
schema conversions also?
