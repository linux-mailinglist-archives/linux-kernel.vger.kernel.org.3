Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE56F50D827
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbiDYEOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiDYENm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:13:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8A1AE;
        Sun, 24 Apr 2022 21:10:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h5so12372200pgc.7;
        Sun, 24 Apr 2022 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J07yJYS22m4KdiXAROXYNCyrX7ou1e3ju2cq0MN47BA=;
        b=dJp4sBIE7mrsvaftVdcx5/hwggvIV06lddbZ0EQS38+1PBaN2vftdW+Lltq+uF3OoO
         SPR0iOg9ri9+3sHI/oUejxxocqZcjGHFZDgzLQKcn4ocjVeR8fkqnWTYIbCIek2IlMAL
         EBbRbtiTnO9749TvKsG0+zI8pJkNAogWVMy3FDHnBUkvXxeJXKUKSUat1uK030Q+O5e6
         PykuqCwhxgTDFLYWsPj/cvBg0769pij3TmBydmliJFTddb8zfPVqO1kMUbHnwgujcq2B
         F/bxVVirncNK/PLTUu19xJqT8G2x47Ln65IhjZYRQON53ed/sEahtw+BZL4rm33BFiv+
         YD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J07yJYS22m4KdiXAROXYNCyrX7ou1e3ju2cq0MN47BA=;
        b=C38zfychjv+Mf3OEet4+QmbzX2pBBy4WU33vjdgGeseJ61QOCmlqsO25XNql8ZqOHd
         aRKcIQI8llFe5m9nmHuRy4/EA3ACwjqtHvjC2ZupDtk6gKZSghPFoWZ5oGWJOAxAGY+X
         FymgOLYWy7MkIXQfviNZG3eynV6FbBvqg2gaI61U6GxgjrrqrTf5LlFJPd1nfntq/BnY
         e+wE4fYPO8T62+hUVau2quZZhI4M0bJfF0dA7b6Q9W1AklkcDx9UzogjoZ6Vd2r+Zuyr
         n/N0amq+Lb6hZ5SAlLw/y72AeE0n222Vc30NrPWb1IBPX/rhHCTkS05qqXe3P8KD5HFe
         d7/Q==
X-Gm-Message-State: AOAM531EKT38q0OdmpeureXQbeyHN1DSlNXKuuZXEbV0wcdW3H8sDGm9
        16pNTdXyvU+xBlXGkvZGNUo=
X-Google-Smtp-Source: ABdhPJyd9dtJLYaaGt59M7aFPkyctBWFkRsocgOcPsrYp5HLF2XDbROcMgywmajwcRSiYO73cSktOw==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr16764423pfj.32.1650859839198;
        Sun, 24 Apr 2022 21:10:39 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00235300b0050a858af58fsm10122202pfj.145.2022.04.24.21.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:10:37 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:10:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: update
 maintainer
Message-ID: <YmYfOwVT7wbBXU3n@google.com>
References: <20220421140255.2781505-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140255.2781505-1-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:02:55PM +0200, Mattijs Korpershoek wrote:
> Fengping has no longer interest and time to maintain this driver so he
> agreed to transfer maintainership over to me.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied, thank you.

-- 
Dmitry
