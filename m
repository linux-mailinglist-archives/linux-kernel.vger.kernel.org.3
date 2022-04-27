Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168B51132C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359276AbiD0IHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359245AbiD0IHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28A153761;
        Wed, 27 Apr 2022 01:04:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so4328768pjb.5;
        Wed, 27 Apr 2022 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VtMI1S/LllZ+nmEBlE73tPnnG9CJxB6us7YB7jLnx8=;
        b=VXYi68QhjRyOoK2LnsYtdP9DRRFpzKenrkxdXPYHzSgZ8JdhUAI4cS+/nx0KaZiBvz
         0CLJ6Ph1qVtRf+I7SLxzmWnWLCZpkWWHSgtH8HJto4ngcPfDNgeJ6Sw0FK8RrG912eZc
         Op4AMbt5/H4rCjY4NvJksUcPijmBTeCmq38LVChmEBSmFe66YzRka7ASuTIgdQEmbt/1
         Ra+ltZ/EKrmPg783D5pmKWlMBa0uPJ/UtNkCPXWiQh3DooVqgB8HHPWtGF/s5dDN0+SU
         D98hSS7LHF5JgtuOjiEE+QHNCrhBhlgDfZKe0b83+VfMe2rrsH1NnD247o0i+OWV33f4
         MUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VtMI1S/LllZ+nmEBlE73tPnnG9CJxB6us7YB7jLnx8=;
        b=GVtmxv1Zncn2SEpJXqNkFiIA961wO5XfTXQQwb1pkKtZ5sOHXiT5GMJDZYy/cc1eOU
         Sc8WB5pIGNQ1PF1I0b71Mh9KcJysiOhGIPNIiH029yLLCgVjR/aLNPK62KbY1eGYxhNH
         fCGzhWmBZGEdWfzbJuDYj2Uo1PLBSp8ZPRMQO2ilQM2Lqb8tK4c++m+YBzyw8YTfEgu3
         SNEzK7BMaV4NRSGJ8DlUESoFV9P925TcwSectPaEzSN7JYNbjHAt4c/Ol8VIkCE4ffTi
         J3oAJIS/Whh5N79P3JONeJQZaLsnNshRS84dzPB6d+1Ex/dLMYybfM9WsJpM2VmZyoo+
         x0Ag==
X-Gm-Message-State: AOAM532a1539Sr5n2IxRxEyjnDE2TeEzsiYuJ0DlChtdB8eUy/EKj5lh
        DK85Hqb8Tv4pqe2AGeS+SCQ=
X-Google-Smtp-Source: ABdhPJxQbosizE4aDS4kiUqMh2r5ZAGQxKQgEgRpq9qoqpBAj/UEpD/n50y9BsNASt2BOmdAFRZI6Q==
X-Received: by 2002:a17:902:7684:b0:156:25b3:ef6b with SMTP id m4-20020a170902768400b0015625b3ef6bmr27057189pll.39.1651046664600;
        Wed, 27 Apr 2022 01:04:24 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:469:f77c:f4fa:b753:7807:4e40])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a70cb00b001cd4989ff50sm1746750pjm.23.2022.04.27.01.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:04:24 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: [PATCH 0/2] dt-bindings: mfd: Add bindings for the Mediatek MT6360
Date:   Wed, 27 Apr 2022 16:03:28 +0800
Message-Id: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series add binding documen for mt6360 mfd architecture and
fix sub-device MT6360 LED

Link: https://lore.kernel.org/lkml/YmHK02g1pC19Oyh6@robh.at.kernel.org/

leds/leds-mt6360.yaml |    2 -
 mfd/mt6360.yaml       |  258 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+), 2 deletions(-)

