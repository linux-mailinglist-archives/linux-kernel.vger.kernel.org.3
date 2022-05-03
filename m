Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CC518B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiECRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiECRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:37:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B439152
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:33:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y19so22908181ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Hz/bqAR1VTUVL5l3DAmDLN9BEMftF3aR7puUQsMw+hw=;
        b=ZHJoJgd2LnOUBbF4UDXKb78neDeR25xDiPOaGPDRRJQ49eGwDIyDDJhCu+lRuitRCu
         jThEoTJB+F1ejX3j1xn71dN1B9Up+ZRBQgTYGcTqirt5X+0AtRCuvFJw7pDONNaiU31b
         HQRUnXyIIVmwgrrS8pdqwWBQfaEXGoGjQS58OmpbPx1004O75K4fMLwQbB9Ct/h69UG6
         gAjPjiU4pQ0ZPgsIMI7ZEGyvRoovMxC5IF1CAnK3IZ+IFNM0T8uLAa3iOIcXZoJcsCMP
         VKIIUU13zPlW1FwDi5sZsLQkG0QAEzTrWCya8bZhVg57oqyhXa7ORUBLq1mjDcVHrrNb
         5e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Hz/bqAR1VTUVL5l3DAmDLN9BEMftF3aR7puUQsMw+hw=;
        b=iPOzli0fBYrB8jc1BCsm+u8MT5yogAyAblJiGXbQVSuoFULFfOFQyHY7HzgRaC1wO7
         /ejdwMNdJpY8xui8u5n3A+xujvDo5ol2KThoc7cuKwG324pWodNRTh44Pik2/CRlh3HB
         hCXeLlcgGeEaQgaTxaz/jQ+2J5XU8sboBgN4vStxlbeufsm+8CVRBeySubfSYu2IWEA8
         Qf4OjAqR8dPOpbBX+8GOVgYuqQ3G5nAJluq7C+zkihc9UASXhEAYsOOH6Lrt1iYa1Exa
         2zAzaxeAFZDjrRQVxX7H/6SWzJGhboOWIcsoBX8tZwJHzvpA4cDxBHWbDFAlnrmapE/D
         Ty9A==
X-Gm-Message-State: AOAM532DdnuopwmM5g260UH7SmAWVE/7pw4z8jsOs2/QPzpGuhRPdpLd
        oWUadUc4L6XGvvSuk/x4OJlKU5Xsu2+BbrWDFPQ=
X-Google-Smtp-Source: ABdhPJyf8OS8N7i7/l5uOAWQG8D/DOtwTnDILdJuMpPaViUYDE7yrw1A6SgU7/6R3wO4W7EpKc/rhiRB7BgHsjStCpo=
X-Received: by 2002:a2e:a547:0:b0:250:5da5:e660 with SMTP id
 e7-20020a2ea547000000b002505da5e660mr4768377ljn.208.1651599226066; Tue, 03
 May 2022 10:33:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:102e:0:0:0:0 with HTTP; Tue, 3 May 2022 10:33:45
 -0700 (PDT)
From:   Amadeo Giannini <greennrodriguez1@gmail.com>
Date:   Tue, 3 May 2022 10:33:45 -0700
Message-ID: <CAN4yompttZ5JyagCWbLC3M_C9NgXtyHgHJhXfs85QnOvGMecmA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
ATTENTION; We render short and long term loan The terms are 2%
interest rate per annul, time duration is 10 year and 1 year grace
period.how much do you need, apply with in
