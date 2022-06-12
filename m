Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7254793E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiFLIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFLIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:12:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB3137AAD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g25so5608366ejh.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocwZVHrRKMoztdMbvtaOW28DDsmAtKFXVot7oqF9910=;
        b=jNGvPiVjyqeVn91lEE66F5UcOu4G13hbpWEepARwjR9v+ldBUKRoLG907i3v2DNV4D
         rSdNin946G3J9XOdVJ425w6ElU88tjvmUC2wgrMYlTMfc4+oxf598xZxw3VyAXMGzueP
         cd0h+DEu3cqe/qGibY8wjNzJGvGzL+r94Rb6nsykRXRG14CeluL1wvovqtmKHvR/qeRg
         MOtGsr4fTDwfYJtdYc0hHtDB9naSV6U0kbv8CcXbcyfgmNNWZPHXwucaiOEOr6g5h1pf
         15PJhHmZkkqJs0tHxgSTRrXjz4ESev7cbqlu9m2CxTXTLXuYqSiUJ6cRkZBhuPm5Hw88
         sZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocwZVHrRKMoztdMbvtaOW28DDsmAtKFXVot7oqF9910=;
        b=JHb1ZBo4tW271d7oq1JfTSLj/OI8TS7P80LnGVqIY4R8UTtshNOFI2RbYpc+RsLCEz
         RQ+EhRUmrE8bnbRMKrIV7smgku0kyHbFbVjEZDmd6lFPzEisMbi4Dm1GBNbdkzP5dZU8
         PjJDIsYFLAJIgQHTr0LZDWVv49JakInC+CbsS3P42LDVcvUtubV2i1PyiuhEUBbc6QN3
         l/SANMZvvp5VwD74HfhKyTLxChvvNDzLnbJA4sV2KeQWffI+B1KE4Azr1Y39dczjjKNt
         zc7XNbu51cknS1vkDm7DCYbCiPs/3lGkluBfQ6Aqou10F2hm7/2tfzCzYNALWYjr3azr
         cjlw==
X-Gm-Message-State: AOAM530pLqEJjlcRmAf9YWWliu7fqSEPhQHbP3ehmw6QIt2SoltvFu5w
        2iIEaAeYfomKfBunKXwZzFk=
X-Google-Smtp-Source: ABdhPJwyG8oM8ujn3e2d4TE1meBi8hyymtnPTtiqlHGv6uZFZRYCMLSfqIIsK7j8Gvv0fO++gO8szg==
X-Received: by 2002:a17:907:971b:b0:711:dc09:fde1 with SMTP id jg27-20020a170907971b00b00711dc09fde1mr26157725ejc.749.1655021559696;
        Sun, 12 Jun 2022 01:12:39 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:bcf1:6e8b:57bb:87f1])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b006ff802baf5dsm2130637eje.54.2022.06.12.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 01:12:39 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk
Subject: [PATCH v2 0/2] staging: r8188eu: simplify some macros
Date:   Sun, 12 Jun 2022 10:11:42 +0200
Message-Id: <cover.1655019752.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YqVyGuACfuroV5ti@kroah.com>
References: <YqVyGuACfuroV5ti@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bit manipulation macros in r8188eu, but are only
ever used for reading single bytes. Remove them.

V2:
  - Split into smaller commits so that it's easier to review

Nam Cao (2):
  staging: r8188eu: replace LE_BITS_TO_1BYTE with clearer codes
  staging: r8188eu: remove unused macros

 .../r8188eu/include/Hal8188ERateAdaptive.h    | 10 +++---
 drivers/staging/r8188eu/include/basic_types.h | 31 -------------------
 2 files changed, 5 insertions(+), 36 deletions(-)

-- 
2.25.1

