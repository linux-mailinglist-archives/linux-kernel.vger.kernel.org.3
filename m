Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B252780D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiEOO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiEOO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:26:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F8E0F7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:26:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z26so13528974iot.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=b0f/0zGlxeNvBazCWHGLnEogvpYVwdbHKraBidfsS+DkeWqlwrQIc3N1xeah/fVea+
         UUdObxZ+WzVcdANTee84Dzmz4V361Es6A4m2OMgNl/blJb+l4TfYIHN1kAGywVPDu2Kj
         BdSeR4I9ln2Eu42xsTHm+op99KhtmX+R33f0vu84er35mC4fxOyghJKiTvdiQuvfgLhj
         /oq6MijwDgaUd/A9mQLTfCIbedS373eDvTiJuXjh+s3ok+1gXW65DBpcztaFeNORrKwo
         1Yx6iTiodl/+nHw/OUUfkQCx5gNB6Q1FUKzvruaDD1If61XnfFlw2DxPdIueq+DhiAbO
         ksDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=RqyDfWYJSKoEDpNSgJ4Uyze7nMEFy9RdStvryx09FH4P7ekbls4OsxXA+mkPrLqTAX
         0MDKaMciLQHtsF/XQkciEMXnPSGPkIIbhi+EMeTe6iouxjy51Z6gQvnI1rFJBJ8PdZr0
         YYnfKLORFSdenIbXTgjkjWbR0KCPMBaDzzNYpoJGsaLnA9EfYW9dHG1+Qa0goy3quabb
         M2wTzzaI0HvVtwM1ssb650WD+A5UNhrdWiXUfQFLWa2NjgiN76hsdY0o/hlQgB22zXTh
         W7PUWT4p/xxsP6VRBvmQ1qXOiUCFu8gncYvpLns44v98XnWZHSzGhPieojrv/YQaaqZV
         NRgg==
X-Gm-Message-State: AOAM530obfl3KDyTvlkuXL7DwNp9hGjSzGQ7x3JqOXlqVls2IJHgJQvQ
        8bDMQ8mZUsteuhPJVPnq0zZjF8qpJglngVoCWOI=
X-Google-Smtp-Source: ABdhPJzybqplS+ZUobLPmrJVOaclSJUS7jYcUxDQFT/Co8y/3rj2stEicX0BOd65DVwhvdT5DTp4HOHjMU3WMBAuCyo=
X-Received: by 2002:a6b:3ec1:0:b0:65a:499f:23a4 with SMTP id
 l184-20020a6b3ec1000000b0065a499f23a4mr5969547ioa.189.1652624771350; Sun, 15
 May 2022 07:26:11 -0700 (PDT)
MIME-Version: 1.0
Sender: soniaavis.ibrahim02@gmail.com
Received: by 2002:a05:6638:34a6:0:0:0:0 with HTTP; Sun, 15 May 2022 07:26:10
 -0700 (PDT)
From:   Frances Patrick <francespatrick49@gmail.com>
Date:   Sun, 15 May 2022 07:26:10 -0700
X-Google-Sender-Auth: aKDpS_Rf5Xd8Vv0PW65YD52D9-I
Message-ID: <CAPwBKQB_T+LRPRdJ_KENQ4AbUV2ss4wtSPLZVB2zbFosOCqN5w@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dearest Friend,

Two Million Euros has been donated to you by Frances and Patrick
Connolly, we are from County Armagh in Northern Ireland, We won the
New Year's Day EuroMillions draw of  =C2=A3115 million Euros Lottery
jackpot which was drawn on New Year=E2=80=99s Day. Email for more details:
francespatrick49@gmail.com Looking forward to hearing from you soon,
