Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06A0485609
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiAEPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiAEPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:40:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C3C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 07:40:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r131so989632oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pMZxUwJrlHUdW2Ao/5zeybJd2l0geh87qed3HqPpftRhZgDYV4RmX2SL+xpYVpcMrB
         M6TsThr3H021wsMqTRselFKlIZ8WWKA4Xe4+WTlJ3aY3yLYewHAjnruxlP5M/IlkTACg
         VN2CMlVHxrO0WH6OxUGndsTa24GqPoACORbABc44RP74jVLsVnQpiOFDb9PgUTJFLOIN
         IeBPeWAfFg8q0dEJcA6SS9oWX9pBJcpPxV2Ksp3rUspl9QPV6GRfUAYram0CjTG6mnZi
         tN6wt3ghsr9cS9zelJpEghNT806MYkRnu8EMhFdo4XgaL1GcmDK+yg9Sy0lIJ/JVggfC
         iDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AKwTdrUqj9n+6KPLeIdydMSmzj0ej/dTNlXzwAoVy0NYCUHQI1qtEccfk96v49pj+N
         /dMEt29mTmIRMe2kg/XVU6PmgznvSCkKn9A9dyKyh2+jIL5rdLyT292OdOKqVjq5/Fpq
         S391+qwIpAxD8qP9HvHLJOIZPj0mjcqez2KklLvc37N3aBUdVW2DmvW/IY/CggKKqhoS
         M2aolbHOIziG9sgcpz31JUecU2E8UrSKHubdf2ijIcebN9whWNL51d09/ioPIB6PospZ
         3qM2SnR7MLe8ugmzRHecuJNWFkttu6F2bgyA4YAjFFUgWNM9w/2+RcE5Ym1lEc+rY/n4
         s10g==
X-Gm-Message-State: AOAM533xz4vlmMZ1f3Emz+Dc6E5GeW4pqP7RE5RXoG6ZZa1mHpMqJe9Z
        3F3tAo+EP2Y48s+dAO1BreYb+76JuADcUDvuxec=
X-Google-Smtp-Source: ABdhPJwD2E5QNif9qUOo1X4o/+FaZ635QW85f3WWUmEy7yJavMSTOw2kxp2AdhtSv7pEDWnuypEzlKmJVtdZWvf6U5E=
X-Received: by 2002:aca:efc4:: with SMTP id n187mr2976950oih.114.1641397238536;
 Wed, 05 Jan 2022 07:40:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:4007:0:0:0:0:0 with HTTP; Wed, 5 Jan 2022 07:40:38 -0800 (PST)
Reply-To: osam93860@gmail.com
From:   Sam Omah <sammande5169@gmail.com>
Date:   Wed, 5 Jan 2022 07:40:38 -0800
Message-ID: <CAKeoT+ze_Nqh55eugjg9edxQVVw=VW+vY77LoCPuhtDvk-cA-A@mail.gmail.com>
Subject: =?UTF-8?Q?Gru=C3=9F=2E_Ich_habe_Sie_vor_einigen_Wochen_wegen_des_Tod?=
        =?UTF-8?Q?es_eines_Staatsangeh=C3=B6rigen_Ihres_Landes=2C_der_bei_Ihnen_den_?=
        =?UTF-8?Q?gleichen_Nachnamen_tr=C3=A4gt=2C_ohne_Ihre_Antwort_kontaktiert_und?=
        =?UTF-8?Q?_er_hat_hier_in_meinem_Land_Togo_eine_Festeinzahlung_=288=2C5_Mi?=
        =?UTF-8?Q?o_Nachricht=2C_damit_ich_Ihnen_mehr_Details_=C3=BCber_die_Transakt?=
        =?UTF-8?Q?ion_geben_kann=2E_Gr=C3=BC=C3=9Fe=2C_Herr_Sam_Omah=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


