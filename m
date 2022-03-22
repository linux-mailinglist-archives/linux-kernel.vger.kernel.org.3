Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C224E489E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiCVVsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiCVVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:48:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D65FF36
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:46:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q14so12499488ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Ghkg/apPZbGZ7N/8CoeV8WfTHlQ8pZzNz4BETbSsRg=;
        b=LYt/FawbSOAV6xJPY0/87OssgSeoMlnzDwHfuc7UfapXPv8UOqNYEq6Y6Jh3NE+34F
         T1ek1KLyuf5g4yRfN1qV5kNOEiuZplBuW0821kmoBmR4jHSbZ/tlhYpXgvpiaaJPk9qA
         jLq8oXtiNk1HhstXpvA8JzT7YjA+tC2ifHRTf2EP8ylvQ+7u1rBn1uSl+u788RBiRLN1
         TdcHiewrHcxIB5Dy/V3E04kzr5J4b/5++m+PnxO2ZdTQz9U+RwnqOKuxGotO/zswxDBM
         4f6cSrhRw54npPekaEdVGWhaR25RC5krS3pZydvumh7XDMCD/hQevVGPIDuQELOKKeFW
         yp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Ghkg/apPZbGZ7N/8CoeV8WfTHlQ8pZzNz4BETbSsRg=;
        b=ow2M8Z3eVai6mG+bamd+RoiRl9OxKhPOGnXR8L0Qcu6Y6VUSrzQzcTp0QmkQOuMuU5
         re5hN6ufBQiVl0YXNvaKq1T/mDwKbn/uQnMp+zb8B5v3MonXzmgeLwVedUN9ji6yQpQG
         MU81aq+10ujQVC0lZurED0WMV5BqOUy70vHy+NXbOsJR83cmmvp8CDrnTT/oVusn5R3l
         vnwjlUEZ8rc/SjHFUuelV37SlXt/ph1ilQ9BLKjXqIzdNlyQmChciKqGULEdxvlnpurS
         OFADzs02Bmo7y3JBhkoJX9FDovroVnXYBI8rZtVx79qe29UANXaTFhFSt1ummbhHpe57
         lOVw==
X-Gm-Message-State: AOAM531eZhLirXWP0XA/81KY/pPD/Rm0hxII70E0/PzA6XR7izLtLebA
        YPYQwDj09+bxbNWFfsx6Lvt6jd8v7H/1VUBHtg28qPsR8AY=
X-Google-Smtp-Source: ABdhPJzcZwq0wcrfd82dW4U9aIYxaNQvd/OaT25QHL8Z00BoGq7J0x2+47+Nwr8DCIcNPXbga4KomzG+tDQjAJj3kqM=
X-Received: by 2002:a2e:b895:0:b0:249:928c:970f with SMTP id
 r21-20020a2eb895000000b00249928c970fmr3246447ljp.193.1647985585728; Tue, 22
 Mar 2022 14:46:25 -0700 (PDT)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 22:46:25 +0100
From:   Harold Banks <Haroldbanks502@gmail.com>
Mime-Version: 1.0
Date:   Tue, 22 Mar 2022 22:46:25 +0100
Message-ID: <CAH8+MdDAfi+Dq3wBKAiu_V7SbBB0A2UC2XFAi24TxDw8mz=Yaw@mail.gmail.com>
Subject: Floor Tiles Order
To:     linux-kernel@vger.kernel.org
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

Good day ,

           My name is Harold Banks, i will like to order  Rubber Floor
Tiles.  below is the specification of my inquiry:

Details:
3=E2=80=B2 X 4=E2=80=B2 PERFORMANCE RUBBER GYM MAT
8MM (5/16=E2=80=9D) THICKNESS

Quantity: 100

I want you to quote me the total pick up prices plus tax and also
advise me the method of payment you do accept.If you don't have this
size or type available email me with the sizes you have
available.Looking forward to doing business with you!Feel free to
contact me with any questions or concerns.Hope you have a pleasant
day.

Thank You
Harold & Sons.Co.Ltd
934-222-5009
