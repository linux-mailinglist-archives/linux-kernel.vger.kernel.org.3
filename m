Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFB534F41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiEZMed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347444AbiEZMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:34:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29695B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:34:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gi33so2782327ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WgNCQNJ6DUznxZMPlMlgkea/oWMdzzwftb3rvbSVmT8=;
        b=Ol1KzcEz5uRMhFpDfWULOl42PZw08Ll/TnaI6gn1y4KlVKhZXqPL2B9d1qEr2rDE5K
         OtNXDLvxRi36PrCFBzQ5x5Dp7FTaPz5mCwTdOrbjoRrXBdnmfERfnx+M9LdFg9n6B/w8
         nj4TONJtui3/RC8fPP0UGtbzYaKNJkBuy0i0LaiOmq2X+pJ3+VQLWbB7xSHMIq5VZ8S6
         zOKALCsaMxDo0szNYCYqO/rj+wErhh1RuGFQJjYuap6Pdq5dVk5sSpc0amez5QRfPkRv
         ximQHMC0ksOQOVojxpmhkt+Z6E2mwLGO2IXZZ4FFNbqGILJQyxnoJJO+vEY2ZKIsXlq4
         emRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WgNCQNJ6DUznxZMPlMlgkea/oWMdzzwftb3rvbSVmT8=;
        b=EbwXJzJYUw9+DDA6SX95t5sUqZDQIr70p5sfSFrRpJqcoReE3LD28eIIBpKgBJf+P7
         UULoNchLlabKUiiIbLosxhW4ArjIyxCcFR+ikmIBJOGHuyqCty8usF9Q3kIHWRIjL40s
         mAIhV2uMexHFez2NANmqM8mZlHtJE7QySO0WYwDeKRsudBV+4fXInIKwpl0wH0DFx3Mx
         piC6MI6PYarsrwSPNgmoIIVM0TfRCo7rOPOpZXzlAnjhEGr0+u/HexM0jAQW/2Opp+NZ
         Pj5eXMr0+oKbp1wG3II4aLCquEhrftBmLWdiFteZe8gfSQpW1kbtY90YVrjLxWl0Sk23
         WEXA==
X-Gm-Message-State: AOAM5336KWyD/kCxDDcTgy7MhDFGa47KB+CjNKcIqzmba0iYarieoKlq
        Xzkkxwyq/vhqtMKC/oN8P++TWOWMlcx1xDWtEby4y5Ny1iI=
X-Google-Smtp-Source: ABdhPJyp9fDjbv5azaWumPlcAs2c1CeiiPodratltbO2nJI9VmyGn/EQ8XYjIfftqRM5sICGVqm0onfcPfrrvfgijYY=
X-Received: by 2002:a17:907:7d93:b0:6fe:21d9:4230 with SMTP id
 oz19-20020a1709077d9300b006fe21d94230mr34230640ejc.42.1653568454706; Thu, 26
 May 2022 05:34:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: koulikoira24@gmail.com
Received: by 2002:a05:6f02:429:b0:1c:b79f:7ef with HTTP; Thu, 26 May 2022
 05:34:14 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Thu, 26 May 2022 12:34:14 +0000
X-Google-Sender-Auth: RmGImbSaiT4Nc6aePXg_Jkfj4iI
Message-ID: <CAC37CRgz6H1giMkN=YqBbmtTpeH=tH8gKJo51Snjh4g8OLM5Zg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you, did you get my two messages? please check and reply me


Pozdrowienia dla Ciebie, dosta=C5=82e=C5=9B moje dwie wiadomo=C5=9Bci? pros=
z=C4=99 sprawd=C5=BA
i odpowiedz mi
