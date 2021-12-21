Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA41547C1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhLUOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:46:37 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:34298 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:46:36 -0500
DKIM-Signature: a=rsa-sha256;
        b=VY5fRUb86ni5GZJ9N0/dKvpexszqjYn8Qk29RcrNg05Uj/PQE4yOFfQuWd9S2TLIUuNG8wyrHCM81cE8SW+rc6C3EUZxX+tJpggfVE1I+Co4OgmgyaxEOrhd6tKlYW6fVShjSGzxWZTBNTUA6A7huSBUwVsCjezgGIjyQGz5CVw=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=E5eZchx2crf4J/jjmBKQpXaLhNDywtHvB7uoyedsUok=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id 8ACA97E035E;
        Tue, 21 Dec 2021 22:46:34 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     robh@kernel.org
Cc:     akingchen@vivo.com, balbi@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Tue, 21 Dec 2021 22:45:58 +0800
Message-Id: <20211221144558.4264-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1640034352.478511.3900650.nullmailer@robh.at.kernel.org>
References: <1640034352.478511.3900650.nullmailer@robh.at.kernel.org>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoYSUxWQh8fQx9OGhoYSx
        hOVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46Sww4Tz5LEyg6PBo3PgEf
        SgwaCxBVSlVKTU9LS0JMQkJOSktNVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSExJTTcG
X-HM-Tid: 0a7ddd755853d999kuws8aca97e035e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Add snps,dis_split_quirk property for dwc3 controller
>> 
>> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
>> ---
>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>
>My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
>yamllint warnings/errors:
>./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:229:3: [error] duplication of key "snps,dis-split-quirk" in mapping (key-duplicates)
>
>dtschema/dtc warnings/errors:
>make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/snps,dwc3.example.dts'
>Traceback (most recent call last):
>  File "/usr/local/bin/dt-extract-example", line 45, in <module>
>    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
>    return constructor.get_single_data()
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in get_single_data
>    return self.construct_document(node)
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 131, in construct_document
>    for _dummy in generator:
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 674, in construct_yaml_map
>    value = self.construct_mapping(node)
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 445, in construct_mapping
>    return BaseConstructor.construct_mapping(self, node, deep=deep)
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 263, in construct_mapping
>    if self.check_mapping_key(node, key_node, mapping, key, value):
>  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 294, in check_mapping_key
>    raise DuplicateKeyError(*args)
>ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>  in "<unicode string>", line 32, column 3
>found duplicate key "snps,dis-split-quirk" with value "{}" (original value: "{}")
>  in "<unicode string>", line 229, column 3

Sorry, i make a mistake, and the snps,dis_split_quirk should be snps,sprs-ctrl-trans-quirk.
And i will renew the patch.

>To suppress this check see:
>    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
>
>make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/usb/snps,dwc3.example.dts] Error 1
>make[1]: *** Waiting for unfinished jobs....

