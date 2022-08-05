Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB74558ABAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiHENdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiHENdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:33:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2477D3ED65
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:33:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gj1so2840317pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SRJq7ym9W33hNUQEvsIKvmNHLOQKGAS74MpbCaquZiI=;
        b=KT0dWDGFTSTP90ki3pJq5M8OGEUMJSQKkn6Bp58hVddnxnGmGIe1UJW7JeMAZhULnI
         hI5KrGl54NT57X2yyt8WHQQF8PeXyymUDJa3BJnLJ6svoQb5KNtR/yBvXLh0/4e5t69j
         JSVBgREtcENn3tDrDN3Y1ysST25QDUaDvIpegFXdH3caWmxZK3xfMmke9w/Hi3khzfI+
         cs2gabd5xX2twNZ2Wen/BK+sNdpZNGTSTIXiGzZlAGXBKDsMOYSdbC4QhDYrVLOPQBNW
         JYwGBLkftmDIbjkao3snwHuVzEuxqmc/aCWrg3MIhYMV9DmxinsqOVXivJrwupp9hZ8v
         i3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SRJq7ym9W33hNUQEvsIKvmNHLOQKGAS74MpbCaquZiI=;
        b=7Q948Q3YfBOTHBwTrHF0Wi4AtcFH1zwxg3v2iCdMWpBynEN0MHHdtUMcldUQyfrGwr
         WSwnM16eaZ4yWTp7aY6xap/qKgqZYK7QpfLRAo3jYSVtBZSWFM5oHsr+EXZ7eBrHY3yO
         jUhcwxPGtInKQXOELjypNelYf9Mbaf83+StfdCl8xG9eJolt3BfSPFq1bGsHHNrgqfwv
         IOKP0+zA6LE9vswzGxOor6rBAEEA6yqlpc+OtN+65tCNJ8Sb3ZyGZ8j8HvcjEKjrmihc
         jhLtUvpjBY723IXBZoU3RlmstEUnHqu9kuBSHP52+dw3TRe5NPY+/uthbDlj9dK6590I
         8Okw==
X-Gm-Message-State: ACgBeo2lIap5FrFEqH5HGXYbT4ejxD66c7dmh4CULOWWaq/8Nke6k0C9
        yzKq8AIv6fwNPLiqRryBGmyERVow4bIbdSbFSjA=
X-Google-Smtp-Source: AA6agR6rAZKjQbJbk3NGF4jqaaPGayAKFzcM88aazGRCuNQRZaPqBn31OictBhluDSlKlxaRdGPWUc22gQgXqOX2guc=
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id
 m18-20020a170902f65200b00156701b9a2amr6853102plg.14.1659706432578; Fri, 05
 Aug 2022 06:33:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:bf14:0:b0:536:dae8:5091 with HTTP; Fri, 5 Aug 2022
 06:33:52 -0700 (PDT)
Reply-To: fasttrustc3@gmail.com
From:   fast trust <dhllometogo37@gmail.com>
Date:   Fri, 5 Aug 2022 14:33:52 +0100
Message-ID: <CAKCZ4ORwKSW5ioJFm=vpn3ACwx25PAPzi5+P6CXVafxA8wCuEQ@mail.gmail.com>
Subject: ???????
To:     dhllometogo37@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,
Go through the documents carefully. Attached is all the related legal
documents from my late husband with the company where our family
inheritance has been deposited.
Regards,
Abda Hassan Mohammed
