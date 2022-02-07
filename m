Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B24ABF12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356420AbiBGNLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447088AbiBGMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:53:18 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B155C0401C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:53:13 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id w5-20020a4a9785000000b0030956914befso13479360ooi.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 04:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VVTWVtpd640Y9AU4fvdSxIMwrpG9a27oVopMV2NmfGs=;
        b=jchDbadWa1Oh3wXqsSmRg0ENq9LfGbPygo8oVErBD3YeETlXQkHTOHtrPnqZ/XCUj0
         U/io97dGT1oLb6/WF4Ir4wHuyosIKXfn8OqQeG+cdfNAJ2T06HC9QjBPa7XUSvQlYPld
         Kv/E/W4tDu/hkyYkgjJdwkhIY/QRnZ9f15fiuV1gegd8ELwcEqjUUo6rc+lyOqOHkN3s
         UlvlRuIsA7z+71XyfISXb0gjCnNT2XmpJG/EIF8vgLcCizAGvH4eopMREWm+Av7i5fzw
         xfZFXjAAENR74RTGkxojjjfm3D/5XoM0NxE7FGjzzAOHH8AYeoHtxlwAbiFRssoO1UV4
         L4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VVTWVtpd640Y9AU4fvdSxIMwrpG9a27oVopMV2NmfGs=;
        b=cMTFpNYfn5pwu7pSJqvdY3cqyL4jEVN8fi5oePieWzy75ihtl5PdOk7wS4l7FIj2SI
         CKKyVo6grnwJeCua4z1NX0XbuG6R1rQeq5mYcYtRDeeMwkyzboK7DPb2nZ+MvLnsRxu4
         COeJfpFBRTecVnNBg388phXqyBdVh+ODZUJz07cGMjP0g06AKQRrqiLMjtLHlPz3tud0
         NBgTgkghclLWVtnmrSDscs/Ill9lAJ3hiBYjz4B3dY96mqxVURFpmel+AlYjOJEtTVkw
         nfMsbTdZ147doOWymtJj7YCQmnP6pnkazlUGl+2aYk+CqZe7/OIIFhijJJsI4N82LAEV
         3H6A==
X-Gm-Message-State: AOAM530GygbD8e4ZDY6XyN2rjONZdocLJQo/e2dLaOXzfYU+CPD+1XGd
        DWqMZfs1ukDNPy7KPsKMwyjtUbECl8xMK6mdnpE=
X-Google-Smtp-Source: ABdhPJzRuGiONl4pmLlHL42Yz+Qo1VBks31WwS/wqqdTvrfQn0WHFtCZLb2Svnyw3ccL5Ca+hLOwbKRPyKyGD0OmePQ=
X-Received: by 2002:a05:6870:660b:: with SMTP id gf11mr653760oab.187.1644238392184;
 Mon, 07 Feb 2022 04:53:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:7f02:0:0:0:0:0 with HTTP; Mon, 7 Feb 2022 04:53:11 -0800 (PST)
Reply-To: contact@embrudis-super-u.com
From:   EMBRUDIS SAS <cjvdistribution2@gmail.com>
Date:   Mon, 7 Feb 2022 13:53:11 +0100
Message-ID: <CADBVrndxzNAQ8RWx0eEqiyvD3ib0uTpP7+UTt-BtXfGqLyHqsQ@mail.gmail.com>
Subject: COLLABORATION.
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

--=20
Hello,

As a national company, Embrudis SAS is present throughout France with
several supermarkets, convenience stores and a number of subsidiaries.
We sell a wide range of food and non-food products as well as various items=
.
We are constantly revising our product line based on customer needs.
We are also investing heavily in new buildings, technology and
facilities and machinery for our business as part of our strategy for
long-term expansion and growth.
We have visited your website and are interested in some of your products.
We would like to establish a business relationship with your company
and ask for the following information:

-A complete list of the products you sell and manufacture -Any
information on delivery times and availability of your products that
we may find useful.
We send you our financial statements and data for your insurance
company to do a credit check. TVA / VAT UE : FR08380636373 Siret :
38063637300033

We want to know after studying your insurance company to know if we
can benefit from a payment within 7 days from the date of invoice.

Cordially
MARTINS Paul

Mobile : +33 (0) 644677027
E-mail:contact@embrudis-super-u.com
EMBRUDIS SAS
ANCIENNE ROUTE DE BARATIER
ENTRAIGUES
05200 EMBRUN
Num=C3=A9ro TVA UE : FR08380636373
