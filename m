Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D252E595
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiETHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbiETHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:00:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C16A63D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:00:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so12784973lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kCCz1rMXqvASGt0+8nSWpqnr2BGj26XTAJy5dg5bcuc=;
        b=T6vWMnF/d7an2NvWN8T9wfDbjZ0S/C1KGYj28m1VzCYgGY5f1HGix23JczGG13/aiG
         +5OnaxodASZwGQqEMMDml+eBFiQfV67b56/1yihxw4/SvaPhhSk3ZuVAoAF1/7MBAeQD
         vnZAGayeo8aihjII7Pk1MoHO8mKyiAQ5DDhR0S6vwhT/ndkWHW47i+/SO9pO3OQ3lIr3
         5ZcWbfeTMvfa/thU7pP5mbYkJe38zdfOlWxXJX/IHvYwCdJH9eO9dhCl4IOIxIB4Jn7k
         8KupnvWLulymBKOT26GEqd6tiLEVDxUcQi0JY/J/zSsx7jY2WbneJQ0mDzWHyWi1tGl1
         erOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kCCz1rMXqvASGt0+8nSWpqnr2BGj26XTAJy5dg5bcuc=;
        b=6P/81xTU7VBAcYpGqwiXTssbXuMdDpUtC/LCtkKPP1skkXgKnDxD0QfTNgfNpqI2PO
         Rp2KLFsxSrrUxKuK6h2Wb8ww+tlDAGvnSzToCWdq3feETrWnvCCa+Aym9UhPKmHVttyp
         1LneacjK+SLY6vfqFP3HnlXn3Yq8++EOSrhyj4XY05YPTdU2EKouCumeEUn7JnQWSu/5
         afAADsn8jObOZEIsu7NU6vOm7GVouyP8iYlhbRNQR8KL4fVYIR8vo4i56G0T+ih6jZLM
         BhPADDOKkI2z4ArtlRQuSZlfNzk+t6l31Z0Gu49JWnD46oi3Y0758DCG0q9gdA6gG/AH
         sCtQ==
X-Gm-Message-State: AOAM5318Z4m+AWfwmQ2shOobj4kC6gLQYRqivDCiejOM5RG970lDzaeg
        gl55ptTXI+MQBpcbJz5xJ4BKGg==
X-Google-Smtp-Source: ABdhPJy6wR430AFBjokcnyv0JB4k1K8iTX33VH2wlKS6T/wU4xDXju/W3bfISPkXtSsE9yku91Gz9w==
X-Received: by 2002:a05:6512:12d6:b0:473:b308:ae0e with SMTP id p22-20020a05651212d600b00473b308ae0emr6285355lfg.664.1653030044824;
        Fri, 20 May 2022 00:00:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f22-20020ac25336000000b0047255d21190sm542661lfh.191.2022.05.20.00.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 00:00:44 -0700 (PDT)
Message-ID: <dcc36d60-23fe-57d6-f85e-c51dc0da71a0@linaro.org>
Date:   Fri, 20 May 2022 09:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <35051bec-98ea-b4c5-f734-06b3f22f3562@linaro.org>
 <8a90ffbc-b376-9115-fb91-0b46d98873b7@linaro.org>
 <40f29157-52c0-001f-6c14-fb90b351756a@linaro.org>
 <20220519221227.B66D3C385AA@smtp.kernel.org>
 <CAA8EJpqjcAcoooaZ6iTSCy4B1x4=HTUgvJ4VqX_Fr_hSMEbfDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpqjcAcoooaZ6iTSCy4B1x4=HTUgvJ4VqX_Fr_hSMEbfDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 03:39, Dmitry Baryshkov wrote:
>> I vaguely recall that the properties had to be extracted during the
>> boot.img creation process to create a table of contents header. But
>> after some time the bootloader started scanning the DTBs directly for
>> the vendor properties and thus the header was deprecated/removed. If the
>> bootloader is doing the scanning then I'm not sure what is preventing
>> the properties from being documented and allowed. I think the main
>> rejection was that the properties were added purely to be extracted
>> during post processing and placed into the table of contents header,
>> i.e. they weren't actually used by the kernel or the bootloader. If they
>> are now used by the bootloader it sounds OK to me if they're kept
>> around.
> 
> Yes, as far as I understand, they are used by the bootloader directly.

This solves only one part of concern form previous discussions - having
entries not used by anything. Kernel still don't use them but some
vendor bootloader (not U-boot) does.

The second problem with these is still not solved - these duplicate what
is already described by compatible. Basically, they do not add any new
hardware description, because board or SoC revision should be encoded
into the compatible. Imagine now adding such "vendor,device-id"
properties to every device node in DTS!

Best regards,
Krzysztof
