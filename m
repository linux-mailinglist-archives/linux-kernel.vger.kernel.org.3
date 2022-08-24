Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FD59F8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiHXMBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiHXMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:01:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3612AC4F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:01:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 62so13153253iov.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=/U60LfQ00AFnbMD6zOYAuJdRXoajgUs5FEr9iJGdcYo=;
        b=k6f+s239zhULw4NoD7kUVcLEtTLB5PPGGERQsD+uIE2cRowTCK6t5xF12yv8frK47j
         ZnzoM7XquEsAqz2KGqzb4LSsxITCr19GyL+/xYLgbhT4R7S+xvi2PWpgHbSZjvQrWgiV
         1KPulSZp7D96ijJi/NplhoMFDZc3rSabTnE/QkQKWhzuP3wG/R+AqttusyWxfv4YiZVQ
         8azWOmV7U7mFCtu8wMw+vrvEtOGB6VfEw/E5AJaC3p1w+UOazVO8ykG09VT2MTzk5lTe
         DxaGjGJxUDhxYKTrBGadzeJG5975eNTsmypkELZ5IWlXo1mXtUT8QyNPfoBcdHjqtm1A
         HnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/U60LfQ00AFnbMD6zOYAuJdRXoajgUs5FEr9iJGdcYo=;
        b=4e0qlSF3tYMrH3QPae4fSKeRXGdTsyuEu+TglPMR99e95f3ldVzqZ/cM2k7GLqRWHm
         ltpmNs8NGh60o6264dKSS+lZr1yxhL3cCWfwBmp7+LyPVtJ+qvwVVC+VjnBWSP5nZVpD
         qDYSxoly6CJBJ32dSiPI0BLyVlwdQxKuFhf8MXsBb8suyQHE4ademOw+Y9Ekm2yOZgIT
         IjBQEceYlS/HNvSoEraju2wppHi/NexFoM+0a2/aoo1zdwWgh7/eRil4YFMLK+8J8sRD
         9S7MN7LTThKNfUIFy7DiB/1KQAnRAlNO2KbEhDzr2Ieh8bmwZJI1GQXKPBKoYn0kxC7A
         vn9w==
X-Gm-Message-State: ACgBeo32/dp+FTtOCwJTh10Tp5Jrm1tlCJpJY4WjtsGGPpNk4Cz2FBH4
        XzCKbh1kchSLV2EE2rVsvbj0pIjli0pSVlOWaY8=
X-Google-Smtp-Source: AA6agR5o2AIm9IOJU/cdOQdRfPIe6ORS1xDG2p8wMNGvJ+r96fcrR5+nH9sGNZsVD/159skGBZ2DQte6+rjaWstN+7I=
X-Received: by 2002:a05:6602:2be6:b0:688:c977:92d2 with SMTP id
 d6-20020a0566022be600b00688c97792d2mr12666392ioy.179.1661342478736; Wed, 24
 Aug 2022 05:01:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:2516:b0:346:82ed:33d1 with HTTP; Wed, 24 Aug 2022
 05:01:18 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL GROUP <fatimaalhajigumsama@gmail.com>
Date:   Wed, 24 Aug 2022 05:01:18 -0700
Message-ID: <CAEdYrVm3mCNie502Fr=rHGi1t9ZthzGC6HOYBJfRD=1v6J0tOg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
h Guten Morgen,
Ben=C3=B6tigen Sie dringend einen Kredit f=C3=BCr den Hauskauf? oder ben=C3=
=B6tigen
Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um zu investieren? ein neues
Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Zahlen Sie uns die
Installationen zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen.
Wir bieten Privatpersonen und Unternehmen Kredite an. Wir bieten
zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz von 2 %. F=C3=BC=
r
weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com..
