Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4C50D325
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiDXQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiDXQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:12:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF7106DC1;
        Sun, 24 Apr 2022 09:09:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so1960020ejb.8;
        Sun, 24 Apr 2022 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GRnYvMYthiO14j3rOxFdH46THRDOp7DQhEpnCN4rSCc=;
        b=BhKCjflQpgVCf4HhsUaejkJ8EqPUozXqYqYzjvRO9F74yIfYiY99oUdToAAJ0NT4+f
         tG77sQ++s2cd2HeXeUlCEWXWy6FyiRr2GCXp9Nu5H9WPTHuI5oeCjMYOH9CV9y/69fYW
         LZsxUL4TZDxeawHSYXzgp004Lqdn5Tnn6gHR7ttErkkocY9c0VJxurYKzpGN4YiZPEna
         oP+Xht9wkmSbcis+wIj5tlTNjTr1/eQY//6C51pHaJqjMqGVR7216ASAflrPshJyiz/E
         LvINzMBuahbHC7vymPLq4sxC5hensawuEmX5zRkuVU+ZWSqpha02mP3r9U1HVQHikYph
         2pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GRnYvMYthiO14j3rOxFdH46THRDOp7DQhEpnCN4rSCc=;
        b=YXWk0jQ3KRlH02F5BtOcJVEe+4hddWHn5gszrxt6+q0YiWSgBsIB7t5SlSL9lEzgUM
         s/eyk7/wznHub2TbyhflHpD4WSPJga+Y2y7Boz87cTB4cl0pyyIjEndb7+7gocJ0sOUB
         2VGK4iepMFZzL45/b/3DGA2jIp4/BSN14DQ2OPlzQJWODo97p6ML7bDoazHtm9SWXD7B
         BdG3um8eZ8cMqPDUOOtHw19MFkD8YsYN3sXitdSgOHIMxp17XbibKQDTwEH58LCBwQ8E
         EmBP/FKuCmZKO6+NdlsXeczG+T5eNtdi+K8xEp8P3cnb7QAcraCSiF9bAJecY7wXlzM5
         XZDA==
X-Gm-Message-State: AOAM531NBFOxQ+o4DQYwJcezXRDjk76ncv0GbtkMs2luFJ9pbecaJgAS
        PYF1k+GGgrbdxUc7yzK2NidxzZhQEwVWPCLm
X-Google-Smtp-Source: ABdhPJzAD7x1l4jW49jnqmFisG1U2MeNPnnuewXOB3Pp5cvZVzHeR1sjJIGYsOTPnPvdAIiYOcMhwQ==
X-Received: by 2002:a17:907:1624:b0:6db:8caa:d71 with SMTP id hb36-20020a170907162400b006db8caa0d71mr12740868ejc.723.1650816591641;
        Sun, 24 Apr 2022 09:09:51 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709064bce00b006f006948581sm2756876ejv.170.2022.04.24.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:09:50 -0700 (PDT)
Date:   Sun, 24 Apr 2022 18:09:48 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jack Doan <me@jackdoan.com>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <YmV2TIcOqTLBA4+U@fedora>
References: <YmTcrq8Gzel0zYYD@jackdesk>
 <20220424160628.GA719092@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424160628.GA719092@roeck-us.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

Aleksa
