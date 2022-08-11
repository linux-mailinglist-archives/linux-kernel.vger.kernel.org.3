Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2D58FCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiHKMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:53:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C28648E8E;
        Thu, 11 Aug 2022 05:53:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so33262828ejp.13;
        Thu, 11 Aug 2022 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc;
        bh=WryfVF+15VZFYKfLIUKNTTEZSZarZs5BtuWlEHuuTZo=;
        b=jeIFNQvvYhFmh73plJypDWARNlw1KqxCAVzKg+psK6EU5DDtee0YDZl2JCRu1X7eUb
         1NrFRCbRtux4PJYTeLbhrLpaQSVHXsHo4f6Xb9HVrUKjwXmbFuvKlPCSPuFSRcBsOjeq
         ZGPwjovC3DdkEDLTWJQMkqCapc1wXmOW8/KE5h2G13dsCqSTnjQmw2u7Unv1/wlMF8XO
         I8Bs1XTgu+6zI+/aAOPdu7X0kHL3MUs+QzECtRsf2NR3cf0066jdispT/q0zR6Go4Kju
         DfVVs57ZSC+srjaTmVFXDhRZeaIsoy3EL5rqjNgc07BnKR/rxiHm4GPol16c8ATIljHr
         tLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc;
        bh=WryfVF+15VZFYKfLIUKNTTEZSZarZs5BtuWlEHuuTZo=;
        b=rpzab44q1K3QeVoDxTwRzjSCFlR1vWeDCyTTO42Gfu+etV+bHZfyuO1oYTjiM5H+UQ
         SMpfjJCdc45RmRhu3DF72FfsXUHeGkUC8GuZVIee7QDPJKR5iX2ajgbgDDpB3+Js398t
         XpJzO2Yyw5ZJbtlN/uJsMC5Tx6gThFniEzuB3eA+wOEIegMNcIiDg9GVTuDJEvq8ZR7w
         bUsdZLo2DQb/cC2RuL8IxqFy7nrx0tJBaozuPJIW0B7s8oPRPU9BhKoDwXFsEU115zyn
         M0TLy8dZIRhX7pIz9WhrOvuL60/TRrwGkgpJ+YoFPp0nB5QtIAc2N2BAKcq+qhnUFMdt
         7OAQ==
X-Gm-Message-State: ACgBeo2S21GW3VEdodOL8z7nN+lLFy8DggCjaBlCMmHna+HElV5tXn2q
        WdBAKyWAxUpkLFAKHVN2gIE=
X-Google-Smtp-Source: AA6agR6GwwZwm44d3KBdaGSOj2tx3f8O3tzQ392JrBl2z+8GKbFP1hNXNyWSNOzc7u7RQr4oPOwTjg==
X-Received: by 2002:a17:906:8a57:b0:730:8b50:610a with SMTP id gx23-20020a1709068a5700b007308b50610amr23897078ejc.557.1660222402349;
        Thu, 11 Aug 2022 05:53:22 -0700 (PDT)
Received: from Ansuel-xps. (host-95-247-89-156.retail.telecomitalia.it. [95.247.89.156])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b0073100dfa7b0sm3486428ejo.8.2022.08.11.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 05:53:21 -0700 (PDT)
Message-ID: <62f4fbc1.170a0220.a7511.8fa9@mx.google.com>
X-Google-Original-Message-ID: <YvT7wPW0pDa5Rqcj@Ansuel-xps.>
Date:   Thu, 11 Aug 2022 14:53:20 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
 <62efbb68.170a0220.88a00.8207@mx.google.com>
 <3515103e-8663-1df9-a184-a383cc0d6aa9@somainline.org>
 <62f158b0.050a0220.9281c.1da3@mx.google.com>
 <736b8e63-3d81-c34d-f693-7dc2120dd885@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736b8e63-3d81-c34d-f693-7dc2120dd885@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 02:48:29PM +0200, Konrad Dybcio wrote:
> 
> 
> On 8.08.2022 15:35, Christian Marangi wrote:
> > On Mon, Aug 08, 2022 at 12:55:36PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 7.08.2022 15:00, Christian Marangi wrote:
> >>> On Mon, Jul 18, 2022 at 06:18:24PM +0200, Christian Marangi wrote:
> >>>> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
> >>>> some additional pcie, sata and usb configuration values, additional
> >>>> reserved memory and serial output.
> >>>>
> >>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>
> >>> Any news for this?Unless Qualcomm naming was different back then, you should simply merge
> >> all of these changes into ipq8064.dtsi, as v1 is often the pre-production,
> >> internal chip revision and only the last one (or the last and second-last)
> >> are shipped in production devices.
> >>
> > 
> > Mhh, this is not the case, there are dev board based on v1 and we also
> > have some device based on v1 (that have some difference for pci and usb)
> > One example is a Netgear r7500 where we have 2 revision one based on
> > ipq8064-v1.0 and one based on ipq8064-v2.0.
> Very interesting.. but if there really are devices shipping with v1, I guess
> it's the correct thing to keep both.
> 
> Konrad

Yep, that is the case. Main concern here is the fact that we have to
have smb208 dtsi variant for each revision and we can't reuse v2 for
ipq8065 and ipq8062 as they have different opp for the CPU core.
(currently not present but they will be added in the future when we will
finally have a correct krait cache devfreq driver)

-- 
	Ansuel
