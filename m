Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9184FBFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbiDKPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiDKPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:13:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442631522
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:11:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bh17so31522307ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=pCJjCOYD1pHvTfEkVbYg6ajc5I2hvGHciFb/sFyrlHY=;
        b=gpXKT43tqtGTzEZYyVUu+KoI+Ti3B/PxcwEDJCLsPuyjVj05Rp2kVeLH4lDKz/v0IQ
         FGC2lHgJcmFoDsWBaFhXQ6E805MJtsOtjLVLztpZo6cHtyHOb9Vb31mGUxRZJP0V4NM7
         5dja41jjOCCg9xz49t+W/PIxhhuhBPAFHAzqgM3iRRXbN0dj5gH2/aofGsZgH0fOyjak
         E0aOHfu7ip8UebMzNLGB9+XC8Gw7BZNP+VyQlD98g5X+dd4zFpG3dF4iNv4OGnM302vf
         5VncVzRR6K2zlVASr9C7gH840TYvI6RvoB/T5AumJobdDYS7fdD7FzFGQGXcfQZMi83A
         lUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=pCJjCOYD1pHvTfEkVbYg6ajc5I2hvGHciFb/sFyrlHY=;
        b=UGJ0epqydY35++iCEkUdOuvWgqeFtsjVkQqLWLvdMF2iB+b4zaEJqF8rLIn2oQmvs0
         3tY+WQIFJRfYAB0FLBROkeQ72aKJB9jV/MEFtLoGXqzXtlGIVqZp1JFtuSOxBV2pUKem
         CcTRy8mUlM0Q+NVLkIKG6iZumN6o9xd++vXAZlAHD8k+js6RDCX174QnIuzF1+un/eGY
         Lt4t0eBSyUjDag1JCByRr2RXWu45dRD+XWAx8iJo+D35IpeyS4oZEdoBf0Qtat02rRJf
         4K5EJgyPHOZWBfptD2JxHd4X6YEJuj7kZFWFqrRG/ittCbufYF0ZRKOYsfgrmrQmx7B/
         ZxXQ==
X-Gm-Message-State: AOAM530XW9AvjMOVaEG4JaAVIeiteuoEGAvjUnJmjIexRtbRJnsSUb7d
        1/dczl+RjtJuIraZtBJ6xmQMFg==
X-Google-Smtp-Source: ABdhPJwLC6bUCnaIFc6oW/Xq/0xCuw+godnXoSeE5FChrONf7ocIGLASLvPmRetx5nLXf3Im5q8Plw==
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id ji3-20020a170907980300b006dbab21738emr29228455ejc.112.1649689865639;
        Mon, 11 Apr 2022 08:11:05 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm12047743ejd.114.2022.04.11.08.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:11:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Apr 2022 17:11:04 +0200
Message-Id: <CJ7I91AXGGCE.24GR11X2CBJ2J@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-input@vger.kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: input: Add bindings for Awinic AW8695
 haptics
X-Mailer: aerc 0.9.0
References: <20220408115311.237039-1-luca.weiss@fairphone.com>
 <1a45984a-752b-6bad-0320-f0946d83f2b9@linaro.org>
 <CJ79EIW9Z89J.YZTZ6AU91TGE@otso>
 <60402ff3-db73-5fc0-bc2a-942d664085ec@linaro.org>
In-Reply-To: <60402ff3-db73-5fc0-bc2a-942d664085ec@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon Apr 11, 2022 at 2:52 PM CEST, Krzysztof Kozlowski wrote:
> On 11/04/2022 10:15, Luca Weiss wrote:
>
> (...)
>
> >>> +  awinic,f0-detection-play-time:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: Drive waveform play times in the first period in th=
e f0 detection
> >>
> >> Use standard unit suffixes for known units (e.g. time).
> >=20
> > While the datasheet doesn't mention any time unit, the value is used to
> > calculate the f0_trace_ms variable (which is milliseconds) but the
> > result also depends on the awinic,f0-preset value, so it's not a raw
> > time value.
>
> I see, ok.
>
> >=20
> >>
> >>> +
> >>> +  awinic,f0-detection-wait-time:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: Waveform wait times in the f0 detection
> >>
> >> Ditto.
> >>
> >>> +
> >>> +  awinic,f0-detection-repeat:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: Repeat times in the f0 detection
> >>> +
> >>> +  awinic,f0-detection-trace:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: Drive waveform play times in the second period and =
later in the f0 detection
> >>> +
> >>> +  awinic,boost-debug:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> >>> +    minItems: 3
> >>> +    maxItems: 3
> >>> +    description: Values for BSTDBG1-3 registers
> >>
> >> Do not encode device programming model (registers) into the binding. Y=
ou
> >> need to define it as a property related to hardware itself, not its
> >> registers (e.g. boost value in mV).
> >=20
> > Unfortunately I couldn't figure the meaning for this and the two values
> > below.
> >=20
> > The datasheet doesn't mention these registers at all and the downstream
> > driver doesn't do anything meaningful with them (other than setting the=
m)
> > nor has any comment to indicate what they do.
> > In the datasheet there's only BSTDBG4 mentioned where bits [5:1] mean
> > PVDD output voltage setting so for these registers it could really be
> > anthing :(
> >=20
> > Maybe someone with more knowledge about LRAs might be able to decipher
> > what tset and r_spare is at least? I unfortunately didn't manage.
>
> Do you have to define them in such case in DT? Maybe it should be part
> of driver?

As these parameters are part of the dts downstream, I assume they differ
per board or actual LRA used.

But I also found other downstream dts examples on github (e.g.
awinic,aw8697_haptic) and they also seemed to use the same values for
these couple of registers (r_spare, tset and bstdbg). Maybe I can gather
more info but it's unlikely I'll be able to get a concrete answer..

Regards
Luca

>
> Best regards,
> Krzysztof

