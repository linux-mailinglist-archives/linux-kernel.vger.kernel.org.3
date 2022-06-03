Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2953C79B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiFCJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiFCJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:35:03 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3172C125
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:35:02 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-f2cd424b9cso9952926fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uEXNiRiF/+3Yj/JxmEhof2WMh5+Z+LzIkCyuz8nTcZ8=;
        b=Y3V+iRCBy07ZDlfH2P6zjcm9N9KVkX5QVsibP9FeC6CEA+4VpnI4WGqiiO7kjf6JDv
         UkCeActA13w+ZP3EhTDMk3NuG/+XXxoc3h+78nMX7IuIBNN5iLwjoJ+ZVVKCBvRt+oIZ
         IAIGBmKmHX3ocdT4wATkT01FvQ6misUvnHKT2MGhlQtmbeWvppsVXG75+SHW2qogXoZm
         Rxsp4Km/itNhpZJ4+LNd+C8QMkHvO23euMrrWmyIT152ifCrbq4uLvNREvFJfXfQZJKz
         noBz5NXupqLcKVIW4Hv9AcH3T4Yr8Q88rux9rb6hifGfebnMYQhdVT4CI5sRaUQoREC+
         HCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uEXNiRiF/+3Yj/JxmEhof2WMh5+Z+LzIkCyuz8nTcZ8=;
        b=fpolra97LmkIxNT38Fn1Ehssf528LIdhFPhP4AW3oIo31Xjw+cLVnDbyT0Fd6SIIfZ
         aEhTsdG7LKWrR/KNiWflEfrQ5cT0kjCfFUfBaSmak4q2JyIzqo8/78zcnEfEgYK4oLLq
         kygY+CX+K+nic+MtbC5y0u65g3JHZo/LNtB+uSyJ9FHoOrWpRTmD/TAZKRFzpNDrsBcC
         cSM4giUZSZegkwNzk3me8uL68GQ0+09sYGJWSiGqdX440JmLvPnb3MrVHjWA7bsvlOBD
         z47ITZkax9lgIf+BdqZ+Do+S/6FDWHqffAgCvslHnncylKOSZrFkiOrBMWu6J4invE4V
         EHlQ==
X-Gm-Message-State: AOAM530weiitwYx+2gUZjorxC/lMoFrF5jbFTZ88NM5UJHvwwQb5a05t
        rbKnYsOqE9j5W76ORptL5BN7+D4F9kysQsAhOeg=
X-Google-Smtp-Source: ABdhPJxCYGRa35lKsB8itD0GSQkPHFgOdS/M9JgV2cnjY8oxFCwrNpM5H8cG0H3TDWAYDilU3jkMcD30Ddp0OmA0fF4=
X-Received: by 2002:a05:6870:e612:b0:f2:91f3:9c07 with SMTP id
 q18-20020a056870e61200b000f291f39c07mr5238968oag.203.1654248901412; Fri, 03
 Jun 2022 02:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:5920:b0:a3:426b:e756 with HTTP; Fri, 3 Jun 2022
 02:35:01 -0700 (PDT)
From:   ajafor simon <lawyersimon1@gmail.com>
Date:   Fri, 3 Jun 2022 09:35:01 +0000
Message-ID: <CAPwRs=qcfB-qfc+dWpHEBBdUKgNqLQ0F_yB2uwdjeV72h6acag@mail.gmail.com>
Subject: =?UTF-8?B?5Lqy54ix55qE6a2P77yM576O5aW955qE5LiA5aSp77yM?=
To:     ajafor simon <lawyersimon1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Lqy54ix55qE6a2P77yM576O5aW955qE5LiA5aSp77yMDQoNCuaIkeaYr+Wkp+W+i+W4iCBTaW1v
biBBamFmb3LvvIzopb/pnZ7mtJvnvo7lpJrlk6XnmoTkuIDlkI3ms5Xlvovku47kuJrogIXvvIzm
mK8gKEVuZywgR2VvcmdlIFdlaSkNCueahOengeS6uuW+i+W4iO+8jOabvuWcqOilv+mdnua0m+e+
juWkmuWTpeeahOWjs+eJjOW8gOWPkeWFrOWPuOaLheS7u+aJv+WMheWVhuOAgiAxMSDmnIggMjEg
5pel77yM5Zyo576O5Zu977yM5LuW55qE5aa75a2Q5ZKM5ZSv5LiA55qE5aWz5YS/5q275LqODQpD
b3ZpZC0xOe+8jOS7luatu+S6juW/g+iEj+eXhe+8m+S7jumCo+S7peWQju+8jOaIkeS4gOebtOWc
qOWQkei0teWbvempu+WkmuWTpeWkp+S9v+mmhuivoumXruaIkeeahOWuouaIt+eahOi/nOS6su+8
jOS9huS5n+ayoeacieaIkOWKn+OAgg0KDQrmiJHlhrPlrprpgJrov4flpJbkuqTkvb/lm6LnlZno
qIDnsL/ov73ouKrku5bnmoTlp5PmsI/vvIzku6Xmib7liLDku5bnmoTku7vkvZXlrrbluq3miJDl
kZjvvIzlm6DmraTmiJHpgJrov4flqpLkvZPmnI3liqHkuI7mgqjogZTns7vjgILnjrDlnKjmiJHl
t7LogZTns7vmgqjljY/liqnlvZLov5jku7flgLwgMTI1MA0K5LiH576O5YWD55qE6LWE6YeR77yM
6L+Z5piv5oiR5bey5pWF5a6i5oi35Zyo6KKr6ZO26KGM5rKh5pS25oiW5a6j5biD5peg5rOV5L2/
55So5LmL5YmN55WZ5LiL55qE5Lu35YC8IDEyNTANCuS4h+e+juWFg+eahOi1hOmHke+8jOS9jeS6
juilv+mdnua0m+e+juWkmuWTpeOAgumHkemineW3suWtmOWFpeOAguacn+W+heW+iOW/q+aUtuWI
sOaCqOeahOadpeS/oe+8jA0KDQoNCuatpOiHtOOAgg0K5aSn5b6L5biIIFNpbW9uIEFqYWZvciAo
RVNRKQ0K5rSb576OIOWkmuWTpSDopb/pnZ4NCg==
