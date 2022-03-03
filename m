Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5A4CC39C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiCCRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiCCRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:24:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798F17EDBE;
        Thu,  3 Mar 2022 09:23:56 -0800 (PST)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXY2Z-1nh1c53Ft9-00Z2Ss; Thu, 03 Mar 2022 18:23:54 +0100
Received: by mail-wm1-f45.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so4555164wms.3;
        Thu, 03 Mar 2022 09:23:54 -0800 (PST)
X-Gm-Message-State: AOAM531WE80095hwxC9srxD1t81rWsvLhsj5CQxJjz9d5nT3HYjED+Hb
        mMzpeqbsfx7m/uawRHMDzRBcLeGEI8ttp+UcTKc=
X-Google-Smtp-Source: ABdhPJwYlRoM2hP10OxnB+6WRepux9dtEcO0p1QjHz+jVcGiljix3iCRUesjDq9hNu0DboMAeNiy4Va1TJMMsMpZFaI=
X-Received: by 2002:a7b:c001:0:b0:381:1afd:5caa with SMTP id
 c1-20020a7bc001000000b003811afd5caamr4615874wmb.35.1646328234412; Thu, 03 Mar
 2022 09:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20220302095008.27b6c6a9@canb.auug.org.au> <CAK8P3a0Quh+PqfBWe-LqzoSgs=ROzu6-8Nq=qceeHRwj8k7uYQ@mail.gmail.com>
 <33a65b94-9e99-2cf8-0b62-95127916ce79@gmail.com>
In-Reply-To: <33a65b94-9e99-2cf8-0b62-95127916ce79@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 3 Mar 2022 18:23:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t+TmBi88wcOraPRUk8uDVnMaDJ4uSZX3DQnnu5zv+Mg@mail.gmail.com>
Message-ID: <CAK8P3a1t+TmBi88wcOraPRUk8uDVnMaDJ4uSZX3DQnnu5zv+Mg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QRSwO+A6XLV6ejg9ogRRoSIug2APYtsOSttWJwKkiickhGAmq2F
 FztoEIrPbCKvqAPZOf+sCncpM71tgHrbhwU4IGMKmeVdmKMAm6Z7jSKHVJTDoZ0YOtmx18K
 q7FjkZr1By/O0T7lXN2e2rXqKIxRKtSvpBqgrzAI8m3y21rtQ8FnYSFcogs42jFMU7Gk0U6
 M2M+NaYqx9TTHffotRvKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRO6lbknXMc=:UViimbzsu8XmS0j9wNoHl3
 NepNcTK1Jo1P4SxrpAep4QY+GckfI42crtKIj6l1W8pamSDfH9Gwe3D3lQ0MiUGjDe/f+wSyC
 4KN8fblcJ6zisEA3P95OoQrPWEtwbopqibwpDAXTxlHHl9Jgg5AQgPYQjVMC1CcXZTDta3ZsN
 37IMYrAz1MeIxXFFaQL89PGzqoUVJdJoum2+m/vCqpq4uD2aYuarDJ5pYlaEK6IrnG4o67sul
 9WT/4w8VacqCPtE8qddbrZ0QMPV8oAmh3scOTymGqSRrTCmqDaS6hWoSOVyRBm2AR9r3vD8UC
 KkJwe7utZaDJISKTgfZ2+xbB4Q9C4rNoYV4eMGikJtfzc5NfgyNZ4zSy/pI9TZS60KoZ2DIYU
 PrSQuP916g8lZ+M4WWUsnhcOGFdPDwCbvYOzJ6DCmuT3kHXh8fIur+0xnHDohAdEgv8y0GxEH
 7G1xZ0mrd3BaA1YWbzmaSNQbJxUDd2qZhndqQuZtRpxvqfa+rs0lv6sbzlBIa8gRbA3eAZJqE
 Rv4UxfdWZmOr2CGyBVF+l47ju0Co2lQLhPAQBOtJ8YYRV3G39qdallPATbIWdTGqXMenwtj6X
 jy9gBFNnUBjPDgQ2QAm9xzgwEEzEiRsEJ0sj/Wg6AbSCwYS0wkwPYEBIH9FIlmHTzUJtUp+Yf
 lAhCD+3izR7cVoMLItC/4/E4m+X3C2XZxLsL26NAYq2j81ZnW/6qUd1VS8oa02wGwYHM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 10:52 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> I send a new pull request with the missing commit included. Please let me know
> if you prefer the commit on top of the old pull request. This would break
> git-bisecting, but the window of commits is rather small.
>
> I fixed my for-next branch yesterday already.

I would prefer a commit on top of the old pull request, so I don't have to
rebase the later merges. I'll be able to apply that on Monday.

       Arnd
