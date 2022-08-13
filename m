Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A205918DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiHMFS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMFS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:18:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0496FDA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:18:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u1so3768029lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=FfLiOArHc8XELsnYYTr1b602n8lqpz8MfJweHlOp/rDjPV0XIr83VI9ZZkgsLNqXJ7
         9kM6r5eAASQeRRPF2v1kkaAXcgelsZgV8lraBapezfUv1PBdKGOw2hTF1V8DODGduBZE
         SgJ1MNcaY4N+88AEX36QVAfP1poz4NNYtl6Vgv79U3d4r6T69DD9FWBcWdiFOfUA5cAk
         oHTJ1qg8VSDhHpfAuMCnruvU7rlQl+hZa51OX4D24kQqahgbo8fdOvdP3O2qZlXxVsCL
         ODqYKhpLuNJqtvz1MINRp2yc25jP90mdRjWnyzNPUQ3xb5lCJFrcE5MY/BuSbE8NQoUT
         sOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=CgrW+OHr00plnhxToNXUBL69TYLFcAtFCF8ULbWYMwf6GgqB6u3z5hasItK6WTN3Yp
         LbzsarCTau6YAyCHf6XvyTJY05T4223RfDc2gRrJ9WJT8UtxXrJU98BxF4wv4/42jmvu
         YY4sbUQdasisMkD5RHzXU+vGf9QtUQfTL7l29+r6YqSBcifv8VSn8HWWu/tISPS2Ea/L
         pWHSBrnXF7pnjaBvnxl4AdX1nDhjpb+GH1kRuyF3WN6+sFnCI7NIU41xVwO0QdazY1PN
         MDJR080FuUmgXPH3fNuF5/ztWt+7htQ4IHPIILBncqFAWGC3nvMWBuGTN+kDarJTbSij
         oAKA==
X-Gm-Message-State: ACgBeo14G+QG7odsjvocnPzv2P3gmuhQmQZs/iyI21W8sMfpCtDA0bre
        V06/feI6R5RmhHaQhKr5k2BvSFioBe0Ebr79VZQ=
X-Google-Smtp-Source: AA6agR5TRANJKbtlNp+cgDWurNiAgADQZNl28UMezlG3T4Tte5Ss+tY57yHjjSs/RjAqOPz/AhVpKrrWKclP3aza0bw=
X-Received: by 2002:a05:6512:b87:b0:48b:2247:684f with SMTP id
 b7-20020a0565120b8700b0048b2247684fmr2377911lfv.593.1660367902448; Fri, 12
 Aug 2022 22:18:22 -0700 (PDT)
MIME-Version: 1.0
Sender: kennethedwards053@gmail.com
Received: by 2002:a2e:81d2:0:0:0:0:0 with HTTP; Fri, 12 Aug 2022 22:18:21
 -0700 (PDT)
From:   Ariel iah <pb589847@gmail.com>
Date:   Sat, 13 Aug 2022 06:18:21 +0100
X-Google-Sender-Auth: C-Ej1kCT2uII60dsJyByzN_x6oI
Message-ID: <CAEa69K1wAnC12cs=3f3rtkdExe-2JHL6JGf7S8M4cRyKgg4mvA@mail.gmail.com>
Subject: CAN YOU DO IT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs  Benaiah and i was diagnosed with cancer about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs. Peninnah Ariel Benaiah
