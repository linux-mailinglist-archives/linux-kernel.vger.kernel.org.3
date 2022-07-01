Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5E563A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGATz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiGATz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:55:57 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F843AE0;
        Fri,  1 Jul 2022 12:55:56 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id v185so5770292ybe.8;
        Fri, 01 Jul 2022 12:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uMax9A8NFrwbVVyDI6R77jb6xuYAOhOqtKIVQprRBvY=;
        b=pUOP+NvqPscING9Hnhse3f7lQbriiRUVVgPdqAJ5CXZwmzz/13cVekJ4TpnRrWRQ+f
         4QhJHNkBEKyTDE8erv15tTa1Ab3E52pkF8Gr/1S8REY/sLWECUpKZSJ8YejGcw4H53ca
         7ZtHh82cVD8cXaBqW0NiDxipWFXz530CDRgCh0iqjBXKN7nyS4Epp9LSkjakL5gFK3IM
         2l6meiJBVhLvgTYzbJ/1Z2fDhcuIVChjSjBIn8MK3pAw7Z2//KS6alc9am3KGB0pZ3tS
         9iBoMJ2NUog7eIrxDgUv37BSoM61Gnop6Ra5b7Oxt5x43fxjeu3yWMHuYzTAtgTgnEA1
         +/Tg==
X-Gm-Message-State: AJIora9i+gtFQ5S5yWQ1RJZaxZvgO2tNlb5W/iamoaFxtbJ67RjElp3p
        jWp4t2zncZoJPDCS5IROOLC+VAqvmnMlu3cQaM4=
X-Google-Smtp-Source: AGRyM1tWDBVNlpPj+dbiA1C3xI/HPvIB1deqlpU2euXZmDOEm5yME5scGzc13E/tdqcjx9YwXCNYt3DaWqgqpN2cYfw=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr17915278ybm.153.1656705356083; Fri, 01
 Jul 2022 12:55:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jul 2022 21:55:45 +0200
Message-ID: <CAJZ5v0jKzEmLLUnoSBDZawHmm0NaU8v4KC+QLVKh0DvhvLbzjQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control update for v5.19-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.19-rc5

with top-most commit 62f46fc7b8c639bc97cc9c69e063c40970b6e14c

 thermal: intel_tcc_cooling: Add TCC cooling support for RaptorLake

on top of commit 3c1d004bdb4e12b4b1dfbdd6a9167ea5003e48cd

 thermal: int340x: Add Meteor Lake PCI device ID

to receive a thermal control update for 5.19-rc5.

This adds a new CPU ID to the list of supported processors in the
intel_tcc_cooling driver (Sumeet Pawnikar).

Thanks!


---------------

Sumeet Pawnikar (1):
      thermal: intel_tcc_cooling: Add TCC cooling support for RaptorLake

---------------

 drivers/thermal/intel/intel_tcc_cooling.c | 1 +
 1 file changed, 1 insertion(+)
