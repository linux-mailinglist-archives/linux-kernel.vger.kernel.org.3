Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC45384EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiE3P3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiE3P3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:29:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299417C6B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:32:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso7755692oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A48EoO51P4Gcyj9u1JH6JYhMxi4n5ymmX2jdoCq5v8g=;
        b=OYP6zuEIZsj9uxtseNAeljMZtQuDbBnmtskH706Cdd9Ca7eADfHlGGATBB+lcMerqy
         l18mFfFDxu5YGKW+NrUE/KaSHDGBPKQoGmCxSGHawq78s7uikcnFmwvro2/rZ/L9SH4g
         /3uHekYvb3pM7TfkY1UFF63tMSnTutZKCHmOJy0cy3KS+KDw9C0GMLtDP5kxYiNVMbE5
         SpWtsmrcBGE7+9bcSwL/rcnMBI6oeSuVwpnv6rHNNtZFTskVA2Qz5dyARmRhauje40BM
         RPL1Dwu1i1tcyfIG6cYJ5efSXdJbSnG3uBoya2SGW671Tgkp6KLLsZUZoIcjuxLLWhQw
         ehKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=A48EoO51P4Gcyj9u1JH6JYhMxi4n5ymmX2jdoCq5v8g=;
        b=w5LwcJNP/ltNo0g7Lq0S+i57qnDNh+ByJh+rGeRZXnY5NF+oBFKpuDyKs6EelVpDwZ
         xDW5TYC21fqASGKM5QwQK+p80BWMTi4Wwv24gLEXA34Wy1HT/OGnhIOxAdjtwlSsc7ki
         n6hqEeV+++TU0O8KBCvOEPIu683vFEB/BAlFKlsnU9yykSp99iXJhdGttUrxorUoj4k/
         58nUtyLWU/WE1SGjHTZO6FNUpna92P0cDcf+eeF+pcU9KH6CHiB1CWK4hWdOzsquvIme
         uVUVOrHW6vCoEJXU3jvHjdXIsSgyLCJyKVDjj3MAYyhabqx8oTRM6AkcfOMFsph6xAgX
         NpyQ==
X-Gm-Message-State: AOAM532WlpKOlM+lswz4NTXuGYSm4HWjBG4NHJHbM90B1XLih1ECCkSk
        lE+8ydyBe4YDOQ1B6Y9KLeUBAvqblrg7tXiqNkI=
X-Google-Smtp-Source: ABdhPJxlHjYsArZ4+dgewuXyVqk8xEHfet6XbxWFygCnWgaf3wqqTKAByRJPSSio3Jf0vOLEeCkf4Phcfa1aITChUMw=
X-Received: by 2002:a9d:76c3:0:b0:60b:9c19:2248 with SMTP id
 p3-20020a9d76c3000000b0060b9c192248mr364660otl.62.1653921157671; Mon, 30 May
 2022 07:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:3951:b0:2f8:4ec5:b9ae with HTTP; Mon, 30 May 2022
 07:32:37 -0700 (PDT)
Reply-To: pomtfoundation2@gmail.com
From:   Peace Of mind Trust <olamidetawiotawio@gmail.com>
Date:   Mon, 30 May 2022 02:32:37 -1200
Message-ID: <CANdjUkKWhQTK7LfE2XUAz1ig+_mXbmDDRcDvwNOAEpzQEoA_Kw@mail.gmail.com>
Subject: =?UTF-8?Q?wohlt=C3=A4tige_Spende?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo lieber Beg=C3=BCnstigter
Sie haben von Peace of Mind eine Spende in H=C3=B6he von 2.000.000,00 =E2=
=82=AC geleistet
Treuhandstiftung (PMT).
Bitte kontaktieren Sie uns =C3=BCber: Pomtfoundation2@gmail.com f=C3=BCr we=
itere
Informationen
wie Sie diese Spendengelder beanspruchen k=C3=B6nnen

bestem Gru=C3=9F
Peace of Mind Trust (PMT)
