Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84725AD192
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiIEL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiIEL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:27:17 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD357249
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:27:15 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e3so3208406uax.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=NV2/h1trZF+YCOo014p3D8c4jYRFgtxU5ChceZVRCjM=;
        b=pNrQlOiXlVTUV4rG+3D4285wyFGOsyrUsHiUvnaiX3TIvWvVqJjHNbdUUsDPciIe4T
         EP+yOhGWGqQLYrSOLDbp3COjnxvAU70kAWbYlXVz4k8m10Nfw2gzp9PDhqaG0F4prBE7
         dY+iMdj+fdAEk0lpTAmxsqYr1KwsNUMk0YMw63SsRGFWkiVOJ+9Fdcrza7JrVxVApJ/+
         87LRK5M23M3zupYN5eBhMqNkCSzElxjBR5XscA5EBl+wZER6T57VXW7wGqACVVn85duC
         EKKX+xl4j0n6MijeC4AKk3Bn1VzlXmxxNJSSTBDIPl/Rz66Rvcmq21xPJBKSVaZAq7rv
         NK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=NV2/h1trZF+YCOo014p3D8c4jYRFgtxU5ChceZVRCjM=;
        b=sONFSQMnuPlMPpaRm8Ermq0AiZeV1iVogwagrFyp1FbX+vcWLGlY4AcTY1rjYvtaTj
         V/bpRuGQEn15aCB/k6ol9gUFpUAby7gUzOqzK2ugJ4lcpfMndR/Wa8qwIqsv2LrnJxo7
         xlkjzuCz/fqbwtoqbrAZ9OcHoclJOaLApEhCdlxiRx2sh2PwiZ3lGumA0luESYuYxbJ8
         kojli9fZA/eGg3d+PF/Hj/4LCLkaf3hNf/ewxZaEJmIiPGSwJNVuyvDalgDuFkxOIo8A
         4rJV4d8cp6i/vurX26136a0/7E6Ipt+P1/ZFuSxHLKcOdRuyJB6y1X62sZw3N5Aisw0H
         gwMw==
X-Gm-Message-State: ACgBeo1G1Lg4+aRyCWVIPg+/heqlYrhTmTRTeS02VJIx5POwqzqboE5s
        gqY/6XDZdh6aUewdqrcRtSYgqqQHorYdq3ITw1c=
X-Google-Smtp-Source: AA6agR7TcoDFlpliiWrfZgtmZlCshKMDWSK36TKCDutc7htCNaCmxdtTCYf3FQ1mMqyeHoWFLGKm94teAq47OKGBBKQ=
X-Received: by 2002:ab0:37d3:0:b0:3ad:a41d:38b0 with SMTP id
 e19-20020ab037d3000000b003ada41d38b0mr2381026uav.5.1662377234833; Mon, 05 Sep
 2022 04:27:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:11c1:b0:2c9:8b9b:fd15 with HTTP; Mon, 5 Sep 2022
 04:27:14 -0700 (PDT)
From:   Fred George <freadgeorge2413@gmail.com>
Date:   Mon, 5 Sep 2022 11:27:14 +0000
Message-ID: <CAEFW8dtmWMfRS+ZFiLWje0kNsq+Juaqj+k235BVeKBh9dFaU6g@mail.gmail.com>
Subject: Re: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Kindly confirm if this e-mail address is still valid so that I will
provide you with beneficial information.

Yours faithfully,

-- 
Fred George. Esq
Principal Attorney of
Dominion Associates
Chambers Barristers & Solicitors
Public Notary , BTD/SORT-CD-00247901
Lome-TOGO West Africa
