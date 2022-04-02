Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFE4F05CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiDBTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiDBTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:30:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21411C32;
        Sat,  2 Apr 2022 12:28:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q19so4986959pgm.6;
        Sat, 02 Apr 2022 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYmWHxsbszuddO/9ZgyitqdZJ9wKMExVzrKSZn+zI80=;
        b=EbMO+erhE+EXhVgg6zPVds4yiSEJBdIfpx9B5sdM71XUv5xOxR0/TThv/ILXxRXHKT
         9MJ6w862H55cADAfzZC1MOTf1ebq21PIGb7Huh23Qpw8dPEW5pW7gNPH5jy0wyb12MQ9
         uAXO0jNf1vssASThYFaJV/tkXh1OBTEzmzgM7yEd4uya2Wr2OqvkhVSWn00GEwKbDZoY
         RjNBGoyLdNueku3VFemvquAjlqZb94vghF9OtbpOunNyaPLx97XKGFPBhF/BXz8fLDaX
         fwGFoJXIB9lOPmy9HuCuRyPxufWQdWRJZWXuQFAFfX3/JyN11TLeZWwbWXSxU1mVMxiO
         cEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYmWHxsbszuddO/9ZgyitqdZJ9wKMExVzrKSZn+zI80=;
        b=z9Xnn3VU42gjRC24CJmgxBn/eKWMx74f4kygn0stY44qdKytM7/0qpXyeo7dAAMAtQ
         OQlc/MLnY9y9p8iK0DMZ0jRpob9CtimxItAHn1d30wDeOqhcwPnODwFXkpPGjYgSsjin
         1977G43T44CN0Ne2wEmsCrxUA3+HxHW4/0uvOwd/h5VRw5JHDLgf/PlNHITFOJB15CoX
         agwFxRnkJk0HGWeI7P5+iAnqxlqVWFyDek4Ckyp07TcPk/XQzE8lK2tamDd7VuhW7FDP
         QW+9Wyci3CzGAirk1xEgvMzMRcCv+Dk1tU5t4U4BSqmLx95yHkqICs1tsWZU+LO2tkq5
         dodg==
X-Gm-Message-State: AOAM530+0zLA3N9gWLG2vfBnHvFmEvbOAbjsuD0q27ij5/1HbMTpnaPM
        msEpvItCZCHxmqX57kCOaHE=
X-Google-Smtp-Source: ABdhPJyg1jzGolvWVgn42aPVnRf6dhTQqPE8ZoXM3QCtPfCaT3mCffgKqVnBqEMZal/tBxK42Fh1ow==
X-Received: by 2002:a63:d13:0:b0:381:f043:c627 with SMTP id c19-20020a630d13000000b00381f043c627mr20166647pgl.168.1648927720859;
        Sat, 02 Apr 2022 12:28:40 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id a24-20020a637f18000000b003821e17819csm5796449pgd.61.2022.04.02.12.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:28:40 -0700 (PDT)
Date:   Sun, 3 Apr 2022 00:58:34 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: qcom: geni-se: Update uart schema
 reference
Message-ID: <20220402192834.GB35664@9a2d8922b8f1>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
 <20220402051206.6115-5-singh.kuldeep87k@gmail.com>
 <78f475c2-c6ed-7f3a-22ec-f5f290cfd107@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f475c2-c6ed-7f3a-22ec-f5f290cfd107@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 05:39:18PM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2022 07:12, Kuldeep Singh wrote:
> > We now have geni based QUP uart controller binding in place as
> 
> s/uart/UART/
> 
> Similar to your previous commit - this could be one, max two sentences...
> 
> > dt-bindings/serial/qcom,serial-geni-qcom.yaml similar to other
> > controllers, update reference in parent schema and while at it, also
> > remove properties defined for the controller from commown wrapper.
> 
> s/commown/common/
> 
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  .../bindings/soc/qcom/qcom,geni-se.yaml        | 18 +-----------------
> >  1 file changed, 1 insertion(+), 17 deletions(-)
> > 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, will update.

-Kuldeep
