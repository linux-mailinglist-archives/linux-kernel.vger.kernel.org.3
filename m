Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DB4C867E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiCAI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiCAI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:29:42 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765561C123
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:29:01 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id j5so6461538vkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=MUtd8G+Pe0V8JRIEIDk0lg9RnQsSwrkz9lTrZ67/YuY=;
        b=IdtET+WbPgVCFu1hTn9NkinfB3t3Qa6eRACt2unl8O2A9Cy5Pq2vBl2OIoxno7sC2d
         Ig4WHn/v1Im7N3ha7bHpS+4uYOh62Mp1ct6aY4nbEwr/RdXg1bfsKO86XS0+b47EQbw0
         7VCl1wuXnJxA7fHrU1FDhRlMdgY0KTTJpK4syL35Baev4pcHawf5I4g1VxrS36vh0jOm
         CJKwqhn0BzdA5dbX2v5axU+IJm2Ern67wkLNFhoW0PMVJ2TOnZRRPmoEJDWETUPS9NJ6
         7mCDARPxJixMvqH8SSU5fDXVqv+RWAwP7yrPhf7YcvLwqQrCu+zDIeLxmysUD+Ivh3nN
         +WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=MUtd8G+Pe0V8JRIEIDk0lg9RnQsSwrkz9lTrZ67/YuY=;
        b=WvLzAFYv5pK64i3ILklRkbSIeOnc+zn1Hew8p0N1dem5WgJgW9IwgRnsAeOwHN0m2m
         AoKd2h5GitmrWJVIi9txQT3LXn4QIxxvlqr6NhzlOtAhYukOcdkPCes2xryvRYENu+Mj
         bE6NKREWvXu1UI2mi5GATPuqJVcHR2hBm1MrEQ4tQnoPFGGaFRbUoE9SEVjnA+RGM6tN
         w4wD3Px5024DQJjzYE1gxOP4NOglb3fVubQ5NocCpV7BluL7CCI0A7c0s5PfqVF1xjow
         aJCKkg4YjHOCfrb3plH/wqzi4UAJlyFRqgOc4Smdh9PR2/gtbu2FAQle6IjwbBpRaXwV
         aKSw==
X-Gm-Message-State: AOAM530ewZVP4vuIS1dhyIM2XJjjQYKlOcexzFa+ZG5wPx0iNAeg21Jv
        yFDbAGp372sibG+vIJ9BCpN70BEQVzPJV/0SLBc=
X-Google-Smtp-Source: ABdhPJwAnSDf0RC4dg11NZrlrPzTDqsFXOEkDp9uWzLbgSJKkVkVUifhqCDdV0xF+CaIzbz8+uP+7+V2pqv8xNcER9A=
X-Received: by 2002:a05:6122:886:b0:332:6a9c:902b with SMTP id
 6-20020a056122088600b003326a9c902bmr9787583vkf.40.1646123340136; Tue, 01 Mar
 2022 00:29:00 -0800 (PST)
MIME-Version: 1.0
Sender: warmaloukmane851@gmail.com
Received: by 2002:a59:7c8:0:b0:295:6ae3:7777 with HTTP; Tue, 1 Mar 2022
 00:28:59 -0800 (PST)
From:   "Mrs Yu. Ging Yunnan" <yunnan1222ging@gmail.com>
Date:   Tue, 1 Mar 2022 09:28:59 +0100
X-Google-Sender-Auth: fOgEdXvsf8PWS5PxUchhKOeXsi8
Message-ID: <CAH3UbtB231sHBTUXOfqougFo+ifEC+KZhk+TXkaRLZ75N6K4sg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of kin to and I want you to stand as the replacement
beneficiary and use the fund to build an orphanage home there in your
country.

Can you handle the project?

Mrs Yu. Ging Yunnan.
