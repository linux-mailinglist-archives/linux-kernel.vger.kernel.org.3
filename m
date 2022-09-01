Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42565A9AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiIAO5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIAO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:57:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C66D9F1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:57:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u17so3459332wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=nGDHMJYfkL4nju2+is+kww5uk6KkuyZpMB47n2TaaUU=;
        b=bPjQMt3ry01QnoedKM/ee37sfchoLPQrJoP1V9xe110Nm7dWnb4CNqEwJcK2/aXs+F
         +ipGc1X/5kjXXNbMW2TrV13+Z09blp5joouk4K026Zm0PrEWqsqG7KgzhUSjvJwumnEz
         V8XZsXCI95auQ0AKJz8+Uy/AxSE2nH+golWc9ubcEACwTKP9/2L1VSWsyTQWNHT8oBhE
         q+zi4+i8kPDUyrRbfkLBUQ9pCgus73VUjZ0UpaCRTe9e0MUWvy99EDloLgW7UThiLP+u
         CbcULIREzkU8j3aYuqZXrj/YrJIpOA3QjRNqToMRZnrX8hh3/+0jcRUv4O8JKJqfes65
         auLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nGDHMJYfkL4nju2+is+kww5uk6KkuyZpMB47n2TaaUU=;
        b=CDbChvoSfFXivDsrR56HthEu4wsmEp4EyekDkaP2ClOHMPCiNNevt2K9mE3UVO8Prz
         xLjunbhz54JORn+A6SJyh5uNuZk297mt3nniLaSpO0aSoyK2plhnN/IwjrX0w22bo84R
         tA2seL7RgXzC7tW/4QtHVLcefz+f/7diOXlpwWEWLbkQQsT4RzELQ2kJgc/1kkwJpJSw
         DcMDcQc2XctNL7wxGAe1yATIkr5S7XQ8j2+5SHxl1TPNH+e63MkK19cd8EVK0pMr1SzG
         JB8wyGlAgXhpyLwMVHtNLmTaDY1RaSrtW3fkJk3bJrGM0nSKVGYOFIiiuLbXrEqygmdy
         1/+g==
X-Gm-Message-State: ACgBeo0hTu8XZ60yvtJHRKS2YoCvMxQi5uFyrbBGIea4M7pqJs6hpLDC
        HZ8b6YX4qR+/3Pzc34VAShU6dW2xh6zlqJwpRlOWymuZgR8=
X-Google-Smtp-Source: AA6agR6Jd+PQj1jHTEPKKWB3Tc09VtW9Z2ChpiIFTtjloFjs6Ysdphz7FJKzL7SHc00/oC9V5RpCgfvKCsqKbI0Ewnw=
X-Received: by 2002:a5d:4587:0:b0:226:d803:2acf with SMTP id
 p7-20020a5d4587000000b00226d8032acfmr12393875wrq.329.1662044244964; Thu, 01
 Sep 2022 07:57:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6885:0:0:0:0:0 with HTTP; Thu, 1 Sep 2022 07:57:23 -0700 (PDT)
From:   Ernest Esene <eroken1@gmail.com>
Date:   Thu, 1 Sep 2022 15:57:23 +0100
Message-ID: <CAL6Vfg1rmy2cE65o_+2qOEO6VewJ82273ybwHb0mOe+ndBr2JA@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unsubscribe
