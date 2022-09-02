Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB195AA5FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiIBCmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBCms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:42:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DFA6AE9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:42:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j5so582794plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=/UVrmSBO/Ah16d2MZfS04mIdJZMZC82FdnBLfIfZvYY=;
        b=ouj3Qpawhor7P8Aig0I7EM736sisP4J1Ik3uSYrPoF2medsxxYLx9ep3Bo4mnbmWo+
         zBteLSvLownPyRyUzknYg+qUkVy9l/YAUpUMqAUgdOMF/PmvDYCe+Z4BH6DSXF3ZVX0x
         LYDKu6/Fapz9raOA36QzN1Kj+TqzEduLB34MJEzevJbB1Va13ZUMlIcIm5cvUEBt79IA
         /LQWTIz7A27oBMdxOgfYJ9PNKgScK21W2ALWynvil7cn+7BmmmbZts7OxXqXuX80Oc2n
         eIklDj5JHG4YHqwjgIwax7UDCYXTjx03g+PNKjMQk6WZqyTeVzxrhg2nmWVqSfrwJCNE
         K38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/UVrmSBO/Ah16d2MZfS04mIdJZMZC82FdnBLfIfZvYY=;
        b=hzyehgo5O3pgixLlFJDpAUpm6BNS8NMRlmYCYp3R8PQOynhzaR/9mUYcvJlgJ7KDH7
         JqBNHvcQfaStTMCdVnGUpkpKviYrBXuG5clFH7tvZa9drlcLxMLjn4R4PVPGAbRE+d+J
         fFA1zLoS+za+uy6/2ShKusssNmzFHn6d0LIpsHtgKytS8WU/pW5Crwc94O9iSPqfB358
         REdhTAo/zDL4djYE1/n3VOUVZxfA8spOHD+eCsUaB4PFmZBvtrAtWn12wx4EGASUUPyj
         UJQdZn//w7sjgEp2wrMrEOklSNXn3jwsvsuL9Q5Ezh6g3zVzTuA3++JGGL6d5zOR4Scf
         wMrA==
X-Gm-Message-State: ACgBeo39iL161ufTZ4I6LOxMBIeS5f7VPrqv1vHTCVixpiUlkCIgHcC0
        5J0m/xMWCSRZoyNNY9LWMOZfgGTyO/51BvJQSuk=
X-Google-Smtp-Source: AA6agR7LmIakBdIXsZZC5GIWQVn8rYmMCBeL65aruRHa1Hl+nCXgDgfXdOeLInR5qMZ7zGezycAlSYmL1BowhqyHDi8=
X-Received: by 2002:a17:903:4c2:b0:175:5c35:fb1f with SMTP id
 jm2-20020a17090304c200b001755c35fb1fmr5661666plb.169.1662086567633; Thu, 01
 Sep 2022 19:42:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: yvonnekidjandan@gmail.com
Received: by 2002:a17:903:264c:b0:174:7c1a:dbf5 with HTTP; Thu, 1 Sep 2022
 19:42:47 -0700 (PDT)
From:   kala manthey <sgtkalamanthey@gmail.com>
Date:   Thu, 1 Sep 2022 19:42:47 -0700
X-Google-Sender-Auth: RTBb0ss-gV8HVqBVWI_nFMXVlrw
Message-ID: <CAD7KYWgzez1BZ_bRJOKpPJDy7Bt6nLsD4mY2iOVFSStG5jfRcg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hallo, heb je mijn e-mails ontvangen? controleer en antwoord mij a.u.b.
