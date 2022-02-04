Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59704A9DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbiBDRir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbiBDRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:38:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310F8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:38:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso6730095pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:mime-version:content-disposition;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KTYic0vVzlwOKua0W5PLTrJu7YME4SKUR8WTfcQOJNZanXbck1b55Ki5fvCXn/A/fB
         KJwFhu2Y85MY0X+6ZLGvIEiaXhq3Jggto5VORFb85jSm3YPedJXlQT53KdPaApox77VB
         bHqT/sxlZVGS8AQSlfK/h1zDbs/ur38W6krbMdsTM/C215sZAmqqMOMduF6C73MDUyZX
         PxsuR1y6I5yzrIy70lKRYDzaZVUMIhl7nX6wUWpilWkjx+HnKpTz1020MqiZTH/5+zmV
         TwfxD8S/31ZaL9uh0FPJnKrTj6unkLGQiK+Gqzq6ysXEhKKqJLki6rhoUJ5EmYhypZD/
         qCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:mime-version
         :content-disposition;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=79DKjsSswFs+FsXkZLTS+sb5SuY6lYb8hR4pKd+itCwSbOKQhYYuOyQwLQgTEAhdLL
         napMMjWH68So0brWyLD+FcssNJRlD7VeiRMAlMUaVLkhkxpyBA8h1zy94Lf7y7IXau8v
         YxrtnJGdg179fSI0SrsEWIkT787gNZ/EZVmIlPCOUI3nxSZO1AApm0iTsZorZZabz1gQ
         ERaeYQpG6Qi15UhCzl24dID7emU0O++GJotYGl1mp8R28YZ09bYrAzh5AhwOyS1MKi43
         COS/Yz577eLVKD6HYOTc8dLYLzz+yo7OrI/AwWQa6Le+kcqS32P1ovaHhfhXkFV68ICJ
         xVMw==
X-Gm-Message-State: AOAM532fMJ5i0HME3HpHVs5xTRQAEZp4BwzThtMUeMlLASsBiRDuq8O9
        fuRmNkIA5SMkUBzbTIl8tpQZV8BiRBkzVA==
X-Google-Smtp-Source: ABdhPJypcJVnScVGRcEKJy9RrdVylDYdoR4vZRWM3Nxhob0GUoqFHSRWgYFi2+VypUjDIztUx+AA3Q==
X-Received: by 2002:a17:902:d2c1:: with SMTP id n1mr3208048plc.76.1643996322505;
        Fri, 04 Feb 2022 09:38:42 -0800 (PST)
Received: from kitty ([12.231.191.170])
        by smtp.gmail.com with ESMTPSA id s10sm3389898pfu.186.2022.02.04.09.38.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:38:42 -0800 (PST)
Date:   Fri, 4 Feb 2022 09:39:10 -0800
From:   MZ <10maurycy10@gmail.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <Yf1kvi9nYUhujK91@kitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

