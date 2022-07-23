Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C30857EA98
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGWAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiGWAUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:20:17 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CAB175B5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:20:16 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 66so2898302vse.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=Nc51/eQ9cQSwWCscr3iwCOjw/rn3SkxF1PeuaSGF4Ec=;
        b=gwf5hN70Z7GLpjKKqjnXsJQLiKNuG/9lNH34Dt1oXgf5XaC+hF7yBpD0iZBhKhQHLN
         EBP214AzVI+Y5VFTLBSE0mbCdr6pwABHBYbp7KjIDbCtQXgO494ohhsAeKwzeCszcWVx
         1GQlK9UGMwBJfSl/SMpf/rd1ObBQnMZf7h7e8F/25JBoz1Osz9rJP1GnTELnWtCumKaY
         ZQen94wxnet0eCYwJJ6tgRDBuR68LvJjiE5EB9EeaDR+KF7Nz4UVECyIlGYIIlbAQ0cG
         X5odF3XOZO0cm6uP+m/vQlUsViPuH7CE25CYRsU6/ZbDg1Nct2zZ4zzfo3cuuy8t3NvC
         kM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=Nc51/eQ9cQSwWCscr3iwCOjw/rn3SkxF1PeuaSGF4Ec=;
        b=DkGiieJQ+y6weg6XIw+Fdao5NkrNrhVXED3kLKVZJ27PCQHTyh5zrYx5B3dy+IpD6X
         eNIZOmQHbJQ9QMwddPtVhK3Ix1WSFJSAiKpg89PFCWoKCS3U6JEyxJVidyCj3fRBwN9m
         RCcB+3evWObu3FFWyc77QsXb3J63S4bUAR7LazGPA5cr5k9gdlQXvOCzbdNWK1mkfAaQ
         zOUmSD4+wqqGCULqQcIcOfAa2pT8T0U1CQT0XEKDEcbNyK/SkbqwrX/9Kum3WROWNyEI
         ayF41gj+a0nSy8//kn7cYr06FwJ45vrDAPzj9rEDdo6RV/6vX+JjA+o9p+SzbDS9Dsiz
         g8Uw==
X-Gm-Message-State: AJIora/z+Vmpj4YJqbBBz4ent0NVbqx5rnT5DJvj6LhFJjAEc2EB9z36
        Y3jHRX0GiBH0dq4B06ddkiD7OrrRw+/1ONyt+8mT876Kqi2WOHYT
X-Google-Smtp-Source: AGRyM1u3vXPaCsnyxxqAFEYFXD3ODyGom4QBlrySkM/6aXWmLPNMVasafsMGCOskKJ+UsA+w5hM7XNGDuBiEq1syhzY=
X-Received: by 2002:a67:d30b:0:b0:357:da78:315a with SMTP id
 a11-20020a67d30b000000b00357da78315amr769130vsj.55.1658535304972; Fri, 22 Jul
 2022 17:15:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrskarimmikael@gmail.com
Sender: elenaadams001@gmail.com
Received: by 2002:a05:612c:27c3:b0:2d5:f4b0:a858 with HTTP; Fri, 22 Jul 2022
 17:15:04 -0700 (PDT)
From:   "Mrs. Karine Mikael" <gayesha337@gmail.com>
Date:   Fri, 22 Jul 2022 13:15:04 -1100
X-Google-Sender-Auth: roNrzuRuvntuCAtFuItZoV03jIc
Message-ID: <CAK+6BO69XwkOZwQVB2fpokYUpw-Fd+iS_pjzVzy+zZpOacJnOg@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
This is one bizarre letter all my years of existence, I got your
e-mail address online while searching for someone reliable that will
assist me to carry out an urgent assignment.

I have been living with leukemia since I was 19 and fifteen years ago
was diagnosed with serious, adrenocortical carcinoma cancer, which has
rendered me utterly useless.

I will gladly give you more details on your responses to my mail.
Regards
Mrs. Karine Mikael
