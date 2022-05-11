Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6B523EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiEKU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347770AbiEKU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:26:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6A37BF9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:26:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 7so2733620pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QZJxyTNwcdR6jXJ6iqWTpwb254N1hEDKTMQ0/smdJ2s=;
        b=bVKQCeLGUTivv+jkAEpIDcqDnE/7eIh7D1RtZQmVAKDlh6jAHqjW+nvNJPRUlZADOf
         /6O1SmlO/HSxs2RQpMmVanuACZub9U91W3zsCohusZ9N1KOieE0guMv3bwdGdwp1aus6
         nxnVJr3Y1/4Ae3Q4zZ8hFYLsB9Jxhx37s6N3D1bCDv/pBWUVmab7iu5GmON7l2POaY2M
         cJlFswNhOsEGe5mKMeTpwhugnZYHXt/zZIj5RAUggWTF1bRR5gr/UchcNRW820TJeCc/
         YQnpYSG7G76VWmadBJUzelLKC418BUODzsynK21BpeU6MmNKqm6DP50Dl1+vrF3F7fcd
         JbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QZJxyTNwcdR6jXJ6iqWTpwb254N1hEDKTMQ0/smdJ2s=;
        b=p+K11vZwHDKhSbk4XQEMDv8Z8aS/E94MFq7gAyRo8y/bipE4u9wud9qAxCFfbFPj75
         wamgKlcFe/sJYa2gVR3+kN0JYVRPPDObi5k2fkU4MBV9JOW7U+TMrMrZsjrhogrNHwsB
         XvNwEcyR6CNyWLriDW56BiIIpMUhOO8bAjOSFc+jrsL5ykaa3wueHJu5nGM80Q1g2bO9
         FtlU5oZCZDSNtM2r2L4F+OBIrAt6qWahqGNIBKZKG/YCFLqk9Q5koFx+QqOxsCOtxfqg
         e1HndGDsle2FLJYaMu25lZkRPSfc1jh9SkGnHvqyrY+2EaCzWVS1gDhpSH4FxDf8MzCD
         DmQw==
X-Gm-Message-State: AOAM531jfFsd215zAIKlQD8wbeaCqB6OfJJ5aYly18asRwy5P2zdZ4jc
        j3sVoiPffFFlvmUjTsN5R9/vpWS4+paOia0qWb0=
X-Google-Smtp-Source: ABdhPJzn1InBzTshcecxsQRXIMkNYTJneuPL1tywU1CpHg7X7NRo2wvwPmYfxa7SreTF6mt9ZleR+n54Zjq+IGjcohk=
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id
 b5-20020a056a00114500b004f63ebca79bmr26764200pfm.41.1652300794217; Wed, 11
 May 2022 13:26:34 -0700 (PDT)
MIME-Version: 1.0
From:   Jack J <jackjosepheq@gmail.com>
Date:   Wed, 11 May 2022 20:26:26 +0200
Message-ID: <CAOKoJwXiSLTT1VybBNGfJuPF9+tiAY1GVFv81XfidEMJXcFnYQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrXmdeV150g15jXldeRLA0K15nXqSDXm9eh16TXmSDXmdeo15XXqdeUINep15TXldeo15nX
qdeVINei15wg16nXnteaINee15zXp9eV15fXqteZINeU157XoNeV15cg16nXmdepINec15Ug15DX
qiDXkNeV16rXlSDXqdedINee16nXpNeX15QNCteV15zXkNeV150g15DXmdeq15ouINeQ16DXkCDX
pteV16gg15DXmdeq15kg16fXqdeoINec16TXqNeY15nXnSDXoNeV16HXpNeZ150uDQoNCteb15wg
15jXldeRLg0K15HXqC4g15In16cg15In15XXltejLg0K
