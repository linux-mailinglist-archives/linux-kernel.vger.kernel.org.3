Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2483F4F5048
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349247AbiDFBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356748AbiDEKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:24:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2380BF52B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:08:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p17so10471673plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=U5u0qbK8e+XZeJGeh5GGrlgv6MBoufCCsM15suO8yWQ=;
        b=Z+wLDReDJS+PV9oDjdsjKvy+1hHKt9IuDw0WoRo5xv8uLgyb1IFGZ421t72FCz1Zep
         BRt2YX6EiXdYJTwdppZYrPaWyIF4rpdfJUSmOmfA2znS8hFKbjGdlEOXvCCTMxAuuqP/
         FRsY8BSLbGK5fzy0kKLmsTsrMM56KdU1pLsWBVdRQdLwBVv/+lPwW50xUdXMFMz1sP7e
         318SfWP3lmbtQH05BF3Bvp6ocuwxRLp1WPBoeaZPMZXIvM6yBcWNs98bMYA86JWh4fM8
         /Ril+OAxX6RKQEuKqohtoy5CeDNMUNusi0s3C45bC+2gTeE4jvukHexlljaY8LpkRdsD
         D9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=U5u0qbK8e+XZeJGeh5GGrlgv6MBoufCCsM15suO8yWQ=;
        b=d3M5nOHHJwuxH16XZjr1Ixj0bGR5drR0DlK9vEKdLTSf2LbWclMhT+gkHtaJL0fE3M
         XAS2DOcg8XrWklDtkdnfc6CiwFPFbvPUMmYxZasV4C+unAPM33pkUO9LMW8iy0KseXBs
         AonQjHxpTUQuEqt42qCgENqk7H6GGsN5Lqa7q/bZ98Xx42YNDXRCUtDLCX0HQ3WC1u0s
         GU98V5ZP6sKECjmcxnomUYABp0UvnY2Rk2NyxcpS8QGhzVhY/pKD3HtjSZynGjuoERaj
         LgkrBmmIyeg+kiEdHuZvQ8KZlFQaapGYdSoyhR9BTTsIrCn6dsv64H8vHp6EVwJ7q1iK
         dv1g==
X-Gm-Message-State: AOAM530YiWE9s0HtWE0hc7LBU/cMC5l2uzZbzxP+ac9XzgF4QQ0bFEBZ
        sVTjiDJacq3f/aq60Q2QLukO+y9x27vnYKJhmXs=
X-Google-Smtp-Source: ABdhPJxfWvJgSDxsQwX+hPdyBAYON209KqkIZsBhwXz6/XfoAkGtOs9+M+QidGu2QUW2rk9TayxVhMpWSpGhtj7ftHw=
X-Received: by 2002:a17:90b:1a8b:b0:1c7:386b:4811 with SMTP id
 ng11-20020a17090b1a8b00b001c7386b4811mr3223151pjb.4.1649153337378; Tue, 05
 Apr 2022 03:08:57 -0700 (PDT)
MIME-Version: 1.0
Sender: bernardagbogbe@gmail.com
Received: by 2002:a17:90b:4d8c:0:0:0:0 with HTTP; Tue, 5 Apr 2022 03:08:56
 -0700 (PDT)
From:   "P.D" <precious101david@gmail.com>
Date:   Tue, 5 Apr 2022 10:08:56 +0000
X-Google-Sender-Auth: htTW9sh5txFJeInbxcuGZBYT4Wo
Message-ID: <CAJaDKchdwZgObhBqMxU7efEjPA17Z3tSmfGVW_LNuOJ6-ZgdDg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting I'm Precious David, from the Southern Cameroon,please I wish
to communicate with you.

I wait for your reply.

(Precious)
