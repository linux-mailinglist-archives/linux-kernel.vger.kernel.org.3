Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C34D884C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiCNPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiCNPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:39:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679985F67
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:38:10 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v62so17589609vsv.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=reOdpSI/DPvZ1X/8G5poXO6puy5IsQ0Hkee97XCgUsc=;
        b=KNq4zhnIC7TVXKLjNfrUuxy5RiTUkCkJ89/TbBe04QsVSvQ5sn4RutT6ZJa3OPzHGr
         R2umBXHXd1HiAPfGVbpMN5GZZIf4H21gz1MZouIgFUsuY5gXfh7MMv2mdD3FHcRAaifS
         TQxM00oEQoUo0nFrAyCFriaF0JsmzfJnSJbnx3ISLr6Nf4XcwGrxJCVdC82ZehaHQQ2S
         SChJ7p4OPWHglS70bmIFjMwQpMD3Cc7JhTNr+6tQp188HXvOV6D+QZ8/IEN27w0MF8cu
         vYUpYVb4f/+GiMdzYN+CAWMK3ONHYIoLE64UKy+HdbrpaX1/7plMvBe9Bn48uVmsv8o+
         O8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=reOdpSI/DPvZ1X/8G5poXO6puy5IsQ0Hkee97XCgUsc=;
        b=QWriVagS+Dopzj76+7Hi22SFhPgaBivA0+6DAz/KI9kMW5dsr3jAUhzpoax1U6ceh4
         uukYWGLsGkOvdmVf2jXGcBgk6VF6/96X8cR2tqwpwZSrq4B58YRBTSSONp0G4Pq6TPqf
         HcFD4AyKn8T/L9flN+d+8oHuZzonSNARMG7ONIbLbtTDoJZavvQVClC5QH8xp9xj08Qn
         vKFlUhWaMJ02KLFNChVKdnR7ydGiHZz8bVfcI9bfyyx1G3uqJGB3JltHtQ1CgcfWt5VG
         K6/ixIKn6B2Z9v9lDw10XQOuaN+AZFgGfeByX/Y2HmP6HWDeQk9tZzRQw2Ptvy63ZxO2
         MkDw==
X-Gm-Message-State: AOAM533EDWY7Mamh/zQzsvyr3vqY9d9vg6b4YGCnQzCrJgUMN7ZUtO04
        CUwochAm3fsFZo+F2TzZzRudmXKs9zyoqTfpjg==
X-Google-Smtp-Source: ABdhPJwc7bsl2NKcGpCbo14xZUudl4mkD6+Fg17/NmfjmZJp/DJgWEV7KF4B2gQdMT1lLHfhqGTOIcjzW1DuABsmV0M=
X-Received: by 2002:a67:2684:0:b0:322:9b71:4831 with SMTP id
 m126-20020a672684000000b003229b714831mr9586830vsm.87.1647272289567; Mon, 14
 Mar 2022 08:38:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6414:0:0:0:0:0 with HTTP; Mon, 14 Mar 2022 08:38:09
 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <lori27362@gmail.com>
Date:   Mon, 14 Mar 2022 08:38:09 -0700
Message-ID: <CAP9eaSjOCDKmufqM4dj70F5U5Y9VNAgYN-RRsFkeJGx=DtjPog@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive my  message i send to you ? I'm waiting for your urgent respond,
