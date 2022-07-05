Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF09567143
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiGEOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiGEOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:36:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8901655BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:36:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u9so16303320oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=E2B6h43tw/IPHIz6obuC/dggkNJmVyG7mdzgcRoRnrQ=;
        b=oNSD49vMe4ar5L/WJAiTqa8b37ZU1rUupo/Bbkvw+2eQLM5muIj31QtyR2zXo/TY9C
         n1NreExX2wC8PvzMKFIqMhYQV79jxXUO8pI8bcQgxn/qbUzz2UNR1+dnrjFz8uLLu5zg
         Ad4R9b9ev+PoIJn75eWfHpCPnJ9H6Ft3CY9pIzTHBHyDwWPSG1z+jUqCdun++gKFTqB3
         /KvDsbvK8x2de4kSHEeIJe0VbaQK3OZGk4QJl3EAW9leJDWSVv1PI6gLFDNHQxtCJcql
         Ax+kplrjsKoDS/aQFdhMsf9iIDeCplOxE7kgXvzK0WqCGSCrFubMgszyE3VeGdDV/yOG
         TmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=E2B6h43tw/IPHIz6obuC/dggkNJmVyG7mdzgcRoRnrQ=;
        b=W7vmJ8rPrbu6GyndMyvXJt0y5LjR4XasZ7CxtvcPEucEvNcaRqpJdz4Eg+xL8W/ZTZ
         GV6RVTSe6bogEZkQVBV2g5zGzSvV1KMkGrKSbZqMcSC3yvXuYB9xU2YBbCwg5Fhbe5/h
         E2bsjeBq0bJICefBYxo3LE/hI1iJbg5H2W0y/qY7eciSIFBXCBQSGE+pF5WTq1MrKlqa
         iBKWiQr9nHo+13Nvq/FgkbREBomnnFpRJomLBuAMfNK+jL/P5oFfLrz6ve3ip5XPKPdG
         3Yxg+fqd8pRW8Xc38Pqp1gGpkLJJ/cEtJ2PnDImdv+yop1jRoCbccs8+dyTPG1Mm1nof
         4BNQ==
X-Gm-Message-State: AJIora9ytc+NqxoTRhWgq0/7r1LkytEN4UpQYw77GbvoERSd55MRrV7b
        NK4JY6o5G+qz0sD5sKZGXTZrQfqGY7K7t3bq4UA=
X-Google-Smtp-Source: AGRyM1t5zuFcGkrptvwOLKdEeFbuJiNe73FAaU6JgEUyCb2gQG1zES9K8mSeP1qHh1gZPbOAF9gH7vGximjmb22Ts8g=
X-Received: by 2002:a05:6808:1a1c:b0:335:6440:8119 with SMTP id
 bk28-20020a0568081a1c00b0033564408119mr19910357oib.59.1657031779974; Tue, 05
 Jul 2022 07:36:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: amidoudjabarou@gmail.com
Received: by 2002:ac9:7a8b:0:0:0:0:0 with HTTP; Tue, 5 Jul 2022 07:36:19 -0700 (PDT)
From:   kalay manthey <sgtkalamanthey@gmail.com>
Date:   Tue, 5 Jul 2022 07:36:19 -0700
X-Google-Sender-Auth: 8it1PRm3-nh340PM_8JOEgc21Eo
Message-ID: <CAJAH3DET8u8qKbxdEiO8cpC2zpGxa=h2vAg9k9aR4c1YL4wtVg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gru=C3=9F! hast du meine vorherigen emails bekommen? Bitte pr=C3=BCfen und =
mir antworten
